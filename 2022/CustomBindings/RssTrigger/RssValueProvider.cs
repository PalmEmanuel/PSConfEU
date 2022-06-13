using Microsoft.Azure.WebJobs.Host.Bindings;
using System;
using System.Reflection;
using System.Threading.Tasks;

namespace PipeHow.RssTrigger
{
    internal class RssValueProvider : IValueProvider
    {
        private readonly ParameterInfo _parameter;
        private readonly object _value;

        public RssValueProvider(ParameterInfo parameter, object value)
        {
            _parameter = parameter;
            _value = value;
        }

        public Type Type => _parameter.ParameterType;

        public Task<object> GetValueAsync() => Task.FromResult(_value);

        // Displayed in the dashboard
        public string ToInvokeString() => "RssPosts";
    }
}
