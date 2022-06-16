#region Azure Artifacts

# Packing the bindings for publishing to a NuGet feed in Azure Artifacts
dotnet pack .\RssTrigger\RssTrigger.csproj -c release -o .\RssTrigger
dotnet pack .\DiscordBinding\DiscordBinding.csproj -c release -o .\DiscordBinding

# Requires Azure Artifacts Credential Provider
# https://github.com/microsoft/artifacts-credprovider
dotnet nuget push --source 'CustomBindings' --api-key 'anything' .\RssTrigger\RssTrigger.1.0.0.nupkg --interactive
dotnet nuget push --source 'CustomBindings' --api-key 'anything' .\DiscordBinding\DiscordBinding.1.0.0.nupkg --interactive

# Installing the bindings

# C#

# Requires Azure Functions Core Tools
# https://github.com/Azure/azure-functions-core-tools
Push-Location .\CSharpFunctionNuget
func extensions install --package DiscordBinding --version 1.0.0 --source CustomBindings
func extensions install --package RSSTrigger --version 1.0.0 --source CustomBindings
Pop-Location

# Using .NET CLI instead of the Azure Functions Core Tools CLI
dotnet add .\CSharpFunctionNuget\CSharpFunctionNuget.csproj package DiscordBinding --version 1.0.0 --interactive
dotnet add .\CSharpFunctionNuget\CSharpFunctionNuget.csproj package RssTrigger --version 1.0.0 --interactive

# PowerShell

# Requires Azure Functions Core Tools
# https://github.com/Azure/azure-functions-core-tools
Push-Location .\PowerShellFunction
func extensions install --package DiscordBinding --version 1.0.0 --source CustomBindings
func extensions install --package RSSTrigger --version 1.0.0 --source CustomBindings
Pop-Location

#endregion

#region Local Installation

# Publishing the bindings as .dll files for local installation
dotnet publish .\DiscordBinding\DiscordBinding.csproj -c release
dotnet publish .\RssTrigger\RssTrigger.csproj -c release

# PowerShell

# Create folder structure and copy bindings
New-Item -Path .\PowerShellFunction\extensions -ItemType Directory
Get-ChildItem -Path @(
    '.\RssTrigger\bin\release\netstandard2.0\publish'
    '.\DiscordBinding\bin\release\netstandard2.0\publish'
) | Copy-Item -Destination .\PowerShellFunction\extensions

Push-Location .\PowerShellFunction

# Requires Azure Functions Core Tools
# https://github.com/Azure/azure-functions-core-tools
# Creates "hidden" extensions.csproj
func extensions sync

# Register local references to the copied binding files
(Get-Content .\extensions.csproj -Raw) -creplace '</ItemGroup>',@'
    <Reference Include="DiscordBinding">
      <HintPath>.\extensions\DiscordBinding.dll</HintPath>
    </Reference>
    <Reference Include="RSSTrigger">
      <HintPath>.\extensions\RSSTrigger.dll</HintPath>
    </Reference>
  </ItemGroup>
'@ | Set-Content -Path .\extensions.csproj

# Run sync again to install the registered bindings
func extensions sync

Pop-Location

#endregion