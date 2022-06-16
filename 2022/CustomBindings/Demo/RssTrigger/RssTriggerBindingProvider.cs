using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Host.Triggers;
using System;
using System.Reflection;
using System.Threading.Tasks;

namespace PipeHow.RssTrigger
{
    internal class RssTriggerBindingProvider : ITriggerBindingProvider
    {
        private readonly INameResolver _nameResolver;

        public RssTriggerBindingProvider(INameResolver nameResolver)
        {
            _nameResolver = nameResolver;
        }

        public Task<ITriggerBinding> TryCreateAsync(TriggerBindingProviderContext context)
        {
            if (context == null)
            {
                throw new ArgumentNullException("context");
            }

            ParameterInfo parameter = context.Parameter;
            RssTriggerAttribute attribute = parameter.GetCustomAttribute<RssTriggerAttribute>(inherit: false);
            if (attribute == null)
            {
                return Task.FromResult<ITriggerBinding>(null);
            }

            return Task.FromResult<ITriggerBinding>(new RssTriggerBinding(attribute, parameter, _nameResolver));
        }
    }
}