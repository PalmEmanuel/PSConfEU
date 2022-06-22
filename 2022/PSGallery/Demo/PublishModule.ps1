#region v2

Import-Module PowerShellGet -MaximumVersion 2.*
$FeedUrlv2 = ''
Register-PSRepository -Name 'PSConfEU' -SourceLocation $FeedUrlv2 -PublishLocation $FeedUrlv2
# Might need to restart the session after registering the repository

# With Azure Artifacts Credential Provider + Device Code
# https://github.com/microsoft/artifacts-credprovider
# Windows: Creates "$($Env:TEMP)\..\MicrosoftCredentialProvider\SessionTokenCache.dat"
# NuGetApiKey is mandatory, but not used with Azure Artifacts - can contain anything
Publish-Module -Path '.\PSConfEUSessionize' -NuGetApiKey 'anystring' -Repository PSConfEU
Install-Module -Name PSConfEUSessionize -Repository PSConfEU
Import-Module -Name PSConfEUSessionize
Get-PSConfEUSession -SessionFilter Next

# With manual PAT credential
$PATSecret =  'personal-access-token' | ConvertTo-SecureString -AsPlainText -Force
$Credential = [pscredential]::new('user@example.com', $PATSecret)
Publish-Module -Path ".\PSConfEUSessionize" -NuGetApiKey 'anystring' -Repository PSConfEU -Credential $Credential

#endregion

#region v3

Import-Module PowerShellGet -MaximumVersion 3.*
$FeedUrlv3 = ''

# PowerShellGet v3 does not yet support Azure Artifacts, but explore these commands in the future!
Register-PSResourceRepository -Name 'PSConfEU' -Uri $FeedUrlv3 # -CredentialInfo $CredInfo
Publish-PSResource -Path ".\PSConfEUSessionize\" -Repository PSConfEU -Credential $Credential

#endregion