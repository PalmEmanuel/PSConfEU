Push-Location ~
Set-PSReadLineOption -PredictionSource None
Import-Module StageCoder

$DemoSteps = @(
    { Disconnect-AzAccount }
    { az logout }
    { Get-AzToken }
    { Get-AzToken -Interactive }
    { Get-AzToken }
)

Set-Demo -Demo ($DemoSteps | ForEach-Object { $_.ToString().Trim() } ) -Timing Manual

Clear-Host
Write-Host 'Getting tokens with only AzAuth' -ForegroundColor Magenta