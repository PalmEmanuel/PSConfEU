using Microsoft.Azure.WebJobs.Host.Protocols;
using System.Collections.Generic;
using System.Globalization;

namespace PipeHow.RssTrigger
{
    internal class RssTriggerParameterDescriptor : TriggerParameterDescriptor
    {
        public string FeedName { get; set; }

        public override string GetTriggerReason(IDictionary<string, string> arguments)
        {
            return string.Format(CultureInfo.CurrentCulture, "New post detected on RSS feed '{0}'.", FeedName);
        }
    }
}
