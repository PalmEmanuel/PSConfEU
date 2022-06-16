using Microsoft.Azure.WebJobs.Description;
using System;

namespace PipeHow.DiscordBinding
{
    [Binding]
    [AttributeUsage(AttributeTargets.Parameter | AttributeTargets.ReturnValue)]
    public class DiscordAttribute : Attribute
    {
        [AutoResolve]
        public string DiscordWebhookUrl { get; set; }

        [AutoResolve]
        public string DiscordUsername { get; set; }
        
        [AutoResolve]
        public string DiscordAvatarUrl { get; set; }
    }
}