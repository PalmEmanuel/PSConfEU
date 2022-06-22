# Push-OutputBinding 'Anything' - Custom Bindings for Azure Functions

Requires the [Azure Functions Core Tools](https://github.com/Azure/azure-functions-core-tools) to run the functions locally.

Requires modifying the `nuget.config` file if using package references from a NuGet feed. If the NuGet feed is a feed in Azure Artifacts, the [Azure Artifacts Credential Provider](https://github.com/microsoft/artifacts-credprovider) should be installed.

The `local.settings.json` is intentionally included to show what the file could look like.
