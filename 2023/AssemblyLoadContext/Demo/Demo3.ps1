Set-PSReadLineOption -PredictionSource None
Import-Module StageCoder
$global:Token = 'eyJhbGciOiAibm9uZSIsICJ0eXAiOiAiSldUIn0K.eyJ1c2VybmFtZSI6ImFkbWluaW5pc3RyYXRvciIsImlzX2FkbWluIjp0cnVlLCJpYXQiOjE1MTYyMzkwMjIsImV4cCI6MTUxNjI0MjYyMn0.'

$DemoSteps = @(
    '.\Demo\Build.ps1'

    'explorer .\out'

    'Import-Module ''Microsoft.Graph.Authentication'' -MaximumVersion 1.28.0'
    'Connect-Graph'
    
    'Import-Module ''.\out\ParseJWT.psd1'' -Verbose'
    'Get-TokenInfo -Token $Token'
    
    '[System.Runtime.Loader.AssemblyLoadContext]::All.Assemblies | Where-Object FullName -like ''System.IdentityModel.Tokens.Jwt*'' | Select-Object *'
)

Set-Demo -Demo $DemoSteps -Timing Manual

Clear-Host
'### DEMO 3 - No more conflicts! ###'