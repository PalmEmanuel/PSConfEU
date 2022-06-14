#region v2

Import-Module PowerShellGet -MaximumVersion 2.*
$FeedUrlv2 = 'https://pkgs.dev.azure.com/pipehow/PSConfEU2022/_packaging/PSConfEU/nuget/v2'
Register-PSRepository -Name 'PSConfEU' -SourceLocation $FeedUrlv2 -PublishLocation $FeedUrlv2
# Might need to restart the session after registering the repository

# With Azure Artifacts Credential Provider + Device Code
# https://github.com/microsoft/artifacts-credprovider
# Windows: Creates "$($Env:TEMP)\..\MicrosoftCredentialProvider\SessionTokenCache.dat"
Publish-Module -Path '.\PSConfEUSessionize' -NuGetApiKey 'anystring' -Repository PSConfEU
Install-Module -Name PSConfEUSessionize -Repository PSConfEU
Import-Module -Name PSConfEUSessionize
Get-PSConfEUSession -SessionFilter Next

# With manual PAT credential
$PATSecret =  Get-Content .\secrets.txt | ConvertTo-SecureString -AsPlainText -Force
$Credential = [pscredential]::new('user@example.com', $PATSecret)
Publish-Module -Path ".\PSConfEUSessionize" -NuGetApiKey 'anystring' -Repository PSConfEU -Credential $Credential

#endregion

#region v3

Import-Module PowerShellGet -MaximumVersion 3.*
$FeedUrlv3 = 'https://pkgs.dev.azure.com/pipehow/PSConfEU2022/_packaging/PSConfEU/nuget/v3/index.json'

# PowerShellGet v3 does not yet support Azure Artifacts, but explore these commands in the future!
Register-PSResourceRepository -Name 'PSConfEU' -Uri $FeedUrlv3 # -CredentialInfo $CredInfo
Publish-PSResource -Path ".\PSConfEUSessionize\" -Repository PSConfEU -Credential $Credential

#endregion