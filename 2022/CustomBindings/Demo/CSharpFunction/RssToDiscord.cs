using Microsoft.Azure.WebJobs;
using PipeHow.RssTrigger;
using PipeHow.DiscordBinding;
using System.Text;

namespace PipeHow.RssToDiscord
{
    public static class RssToDiscord
    {
        [FunctionName("RssToDiscord")]
        public static void Run(
            [RssTrigger(FeedName = "LoremRSS", FeedUrl = "%FeedUrl%"/*, TableConnectionString = "has-default-value"*/)] RssPost[] data,
            [Discord(
                DiscordAvatarUrl = "https://pbs.twimg.com/profile_images/1498991285809655811/0IwmQcfF_400x400.jpg",
                DiscordUsername = "PSConf EU Bot",
                DiscordWebhookUrl = "webhook-url"
            )] out string message)
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendLine($"**New post(s) on RSS feed '{ data[0].Source }'!**\n");
            foreach (var post in data)
            {
                sb.AppendLine($"**{post.Title}**");
                sb.AppendLine(post.Description);
                sb.AppendLine(post.Url);
                sb.AppendLine();
            }

            message = sb.ToString();
        }
    }
}