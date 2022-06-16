using Microsoft.Azure.WebJobs;
using System.Net.Http;
using System.Text;
using System.Text.Json;
using System.Threading;
using System.Threading.Tasks;

namespace PipeHow.DiscordBinding
{
    public class DiscordAsyncCollector : IAsyncCollector<string>
    {
        private static HttpClient client = new HttpClient();
        private string webhookUrl;
        private string username;
        private string avatarUrl;

        public DiscordAsyncCollector(DiscordAttribute attr)
        {
            webhookUrl = attr.DiscordWebhookUrl;
            avatarUrl = attr.DiscordAvatarUrl;
            username = attr.DiscordUsername;
        }

        public async Task AddAsync(string message, CancellationToken cancellationToken = default)
        {
            var jsonObject = JsonSerializer.Serialize(new
            {
                avatar_url = avatarUrl,
                username = username,
                content = message
            });
            var stringContent = new StringContent(jsonObject, Encoding.UTF8, "application/json");
            await client.PostAsync(webhookUrl, stringContent);
        }

        public Task FlushAsync(CancellationToken cancellationToken = default)
        {
            return Task.CompletedTask;
        }
    }
}