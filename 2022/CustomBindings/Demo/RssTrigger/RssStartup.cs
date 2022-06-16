using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Hosting;
using PipeHow.RssTrigger;

[assembly: WebJobsStartup(typeof(RssStartup))]
namespace PipeHow.RssTrigger
{
    public class RssStartup : IWebJobsStartup
    {
        public void Configure(IWebJobsBuilder builder)
        {
            builder.AddExtension<RssExtensionConfigProvider>();
        }
    }
}