using Azure;
using Azure.Data.Tables;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Description;
using Microsoft.Azure.WebJobs.Host;
using Microsoft.Azure.WebJobs.Host.Executors;
using Microsoft.Azure.WebJobs.Host.Listeners;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.ServiceModel.Syndication;
using System.Threading;
using System.Threading.Tasks;
using System.Xml;

namespace PipeHow.RssTrigger
{
    internal class RssFeedListener : IListener
    {
        private readonly ITriggeredFunctionExecutor _executor;
        private readonly TableClient _tableClient;
        private readonly string _feedUrl;

        private const int RSS_MONITOR_INTERVAL_MINUTES = 1;

        public RssFeedListener(ITriggeredFunctionExecutor executor, RssTriggerAttribute attribute, INameResolver nameResolver)
        {
            _executor = executor;
            // Resolve url from app settings if needed
            _feedUrl = nameResolver.ResolveWholeString(attribute.FeedUrl);

            // Get [AutoResolve] attribute from connection string, to find Default
            AutoResolveAttribute autoResolveAttribute = attribute.GetType().GetProperty("TableConnectionString").GetCustomAttribute<AutoResolveAttribute>();

            var resolvedConnectionString = nameResolver.ResolveWholeString(attribute.TableConnectionString ?? autoResolveAttribute.Default);
            _tableClient = new TableClient(resolvedConnectionString, nameResolver.ResolveWholeString(attribute.FeedName));
        }

        public async Task StartAsync(CancellationToken cancellationToken)
        {
            // Ensure table exists
            try
            {
                // Ensure creating the table fails if it exists
                await _tableClient.CreateAsync();

                // When the table is just created, find and add all current posts
                // Otherwise we trigger the function for every post in feed
                SearchFeedAndAddToTable(_feedUrl);
            }
            catch (RequestFailedException ex)
            {
                if (ex.ErrorCode != "TableAlreadyExists")
                {
                    throw ex;
                }
            }

            // Start monitoring the feed until cancelled
            while (!cancellationToken.IsCancellationRequested)
            {
                var posts = SearchFeedAndAddToTable(_feedUrl);

                if (posts.Count() > 0)
                {
                    await _executor.TryExecuteAsync(new TriggeredFunctionData
                    {
                        TriggerValue = posts.ToArray()
                    }, CancellationToken.None);
                }

                await Task.Delay(TimeSpan.FromMinutes(RSS_MONITOR_INTERVAL_MINUTES), cancellationToken);
            }
        }

        private IEnumerable<RssPost> SearchFeedAndAddToTable(string url) {
            XmlReader reader = XmlReader.Create(url);
            SyndicationFeed feed = SyndicationFeed.Load(reader);
            reader.Close();

            var posts = feed.Items.Select(p => new RssPost
            {
                Source = feed.Title.Text,
                Title = p.Title.Text,
                Description = p.Summary.Text,
                Url = p.Id
            }).ToList();

            var currentPosts = GetCurrentPosts();
            var newPosts = posts.Where(p => !currentPosts.Any(c => c.RowKey == p.Title));

            if (newPosts.Count() > 0)
            {
                AddPostsToTable(newPosts);
            }

            return newPosts;
        }

        private IEnumerable<TableEntity> GetCurrentPosts()
        {
            return _tableClient.Query<TableEntity>().OrderByDescending(e => e.Timestamp).ToList();
        }

        private void AddPostsToTable(IEnumerable<RssPost> posts)
        {
            var transactions = posts.Select(p =>
            {
                var entity = new TableEntity();
                entity.PartitionKey = _tableClient.Name;
                entity.RowKey = p.Title;
                entity.Add("Title", p.Title);
                entity.Add("Description", p.Description);
                entity.Add("Url", p.Url);
                entity.Add("Source", p.Source);

                return new TableTransactionAction(TableTransactionActionType.UpsertMerge, entity);
            });

            _tableClient.SubmitTransaction(transactions);
        }

        public Task StopAsync(CancellationToken cancellationToken) => Task.CompletedTask;
        public void Cancel() {}
        public void Dispose() {}
    }
}