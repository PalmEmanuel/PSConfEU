# Presentations for PowerShell Conference Europe 2022

## Push-OutputBinding 'Anything' - Custom Bindings for Azure Functions

Requires the [Azure Functions Core Tools](https://github.com/Azure/azure-functions-core-tools) to run the functions locally.

Requires modifying the `nuget.config` file if using package references from a NuGet feed. If the NuGet feed is a feed in Azure Artifacts, the [Azure Artifacts Credential Provider](https://github.com/microsoft/artifacts-credprovider) should be installed.

The `local.settings.json` is intentionally included to show what the file could look like.

### DiscordBinding

An example of a custom output binding that posts to a Discord channel using a webhook.

### RSSTrigger

An example of a custom trigger binding that monitors an RSS feed and triggers the function when a new post is found, tracking previously found posts in an Azure Storage Table.

## Creating Your Own PSGallery with Azure Artifacts

For all the code in the demo to work, the [Azure Artifacts Credential Provider](https://github.com/microsoft/artifacts-credprovider) should be installed.
