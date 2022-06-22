$ModuleName = 'PSConfEUSessionize'

# Create module directory and set location to there
New-Item -Name $ModuleName -ItemType Directory
Push-Location ".\$ModuleName"

# Create .psm1 module script file with agenda id for PSConfEU2022 in a variable
New-Item -Path "$ModuleName.psm1" -Value @'
function Get-PSConfEUSession {
    param (
        [ValidateSet('Current','Next','All')]
        [string]$SessionFilter = 'All'
    )
    
    
}
'@

# Create splatting hashtable for manifest
$ManifestInfo = @{
    Path = "$ModuleName.psd1"
    Description = 'A module to get information about PowerShell Conference Europe 2022.'
    RequiredModules = 'PSessionize'
    RootModule = "$ModuleName.psm1"
    ModuleVersion = '1.0.0'
    CompanyName = 'pipe.how'
    Author = 'Emanuel Palm'
    FunctionsToExport = 'Get-PSConfEUSession'
    AliasesToExport = @()
    CmdletsToExport = @()
    VariablesToExport = @()
}
# Create .psd1 module manifest file
New-ModuleManifest @ManifestInfo

Pop-Location