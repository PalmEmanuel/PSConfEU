using PipeHow.DiscordBinding;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Hosting;

[assembly: WebJobsStartup(typeof(DiscordStartup))]
namespace PipeHow.DiscordBinding
{
    public class DiscordStartup : IWebJobsStartup
    {
        public void Configure(IWebJobsBuilder builder)
        {
            builder.AddExtension<DiscordExtensionConfigProvider>();
        }
    }
}