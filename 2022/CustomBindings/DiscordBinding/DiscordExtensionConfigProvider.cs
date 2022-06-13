using Microsoft.Azure.WebJobs.Description;
using Microsoft.Azure.WebJobs.Host.Config;

namespace PipeHow.DiscordBinding
{
    [Extension("DiscordBinding")]
    public class DiscordExtensionConfigProvider : IExtensionConfigProvider
    {
        public void Initialize(ExtensionConfigContext context)
        {
            context.AddBindingRule<DiscordAttribute>().BindToCollector(attr => new DiscordAsyncCollector(attr));
        }
    }
}