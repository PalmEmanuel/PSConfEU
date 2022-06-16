using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Host.Bindings;
using Microsoft.Azure.WebJobs.Host.Listeners;
using Microsoft.Azure.WebJobs.Host.Protocols;
using Microsoft.Azure.WebJobs.Host.Triggers;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Reflection;
using System.Threading.Tasks;

namespace PipeHow.RssTrigger
{
    internal class RssTriggerBinding : ITriggerBinding
    {
        private readonly INameResolver _nameResolver;
        private readonly ParameterInfo _parameter;
        private readonly RssTriggerAttribute _attribute;
        private readonly Dictionary<string, Type> _bindingDataContract;

        public RssTriggerBinding(RssTriggerAttribute attribute, ParameterInfo parameter, INameResolver nameResolver)
        {
            _nameResolver = nameResolver;
            _parameter = parameter;
            _attribute = attribute;

            _bindingDataContract = new Dictionary<string, Type>();
        }

        public Type TriggerValueType => typeof(object);

        public IReadOnlyDictionary<string, Type> BindingDataContract => _bindingDataContract;

        public Task<ITriggerData> BindAsync(object value, ValueBindingContext context)
        {
            if (!(value is IEnumerable<RssPost>)) throw new NotSupportedException("A list of RssPosts is required.");

            var bindingData = new Dictionary<string, object>(StringComparer.OrdinalIgnoreCase)
            {
                {"data", value}
            };

            var jsonData = _parameter.ParameterType == typeof(string)
                ? JsonConvert.SerializeObject(value, Formatting.Indented)
                : value;

            var valueProvider = new RssValueProvider(_parameter, jsonData);
            return Task.FromResult<ITriggerData>(new TriggerData(valueProvider, bindingData));
        }

        public ParameterDescriptor ToParameterDescriptor()
        {
            return new RssTriggerParameterDescriptor
            {
                Name = _parameter.Name,
                Type = "RssTrigger",
                FeedName = _attribute.FeedName
            };
        }

        public Task<IListener> CreateListenerAsync(ListenerFactoryContext context)
        {
            if (context == null)
            {
                throw new ArgumentNullException("context");
            }

            return Task.FromResult<IListener>(new RssFeedListener(context.Executor, _attribute, _nameResolver));
        }
    }
}