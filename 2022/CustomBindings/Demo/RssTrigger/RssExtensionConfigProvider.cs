using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Description;
using Microsoft.Azure.WebJobs.Host.Config;

namespace PipeHow.RssTrigger
{
    [Extension("RssBinding")]
    internal class RssExtensionConfigProvider : IExtensionConfigProvider
    {
        private readonly INameResolver _nameResolver;

        public RssExtensionConfigProvider(INameResolver nameResolver)
        {
            _nameResolver = nameResolver;
        }

        public void Initialize(ExtensionConfigContext context)
        {
            context.AddBindingRule<RssTriggerAttribute>().BindToTrigger(new RssTriggerBindingProvider(_nameResolver));
        }
    }
}