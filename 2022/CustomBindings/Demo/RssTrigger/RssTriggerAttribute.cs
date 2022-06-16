using Microsoft.Azure.WebJobs.Description;
using System;

namespace PipeHow.RssTrigger
{
    [Binding]
    [AttributeUsage(AttributeTargets.Parameter)]
    public class RssTriggerAttribute : Attribute
    {
        [AutoResolve]
        public string FeedName { get; set; }

        [AutoResolve]
        public string FeedUrl { get; set; }

        [AutoResolve(Default = "%AzureWebJobsStorage%")]
        public string TableConnectionString { get; set; }
    }
}