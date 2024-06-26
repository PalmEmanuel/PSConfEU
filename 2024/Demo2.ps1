Push-Location ~
Set-PSReadLineOption -PredictionSource None
Import-Module StageCoder

$DemoSteps = @(
    { Get-AzToken }
    { Connect-AzAccount }
    { Get-AzToken }
    { Get-AzToken | Set-Clipboard }
    { Disconnect-AzAccount }
    { Get-AzToken }
    { az login }
    { Get-AzToken | Set-Clipboard }
    { az logout }
)

Set-Demo -Demo ($DemoSteps | ForEach-Object { $_.ToString().Trim() } ) -Timing Manual

Clear-Host
Write-Host 'Getting cached tokens from other tools' -ForegroundColor Magenta