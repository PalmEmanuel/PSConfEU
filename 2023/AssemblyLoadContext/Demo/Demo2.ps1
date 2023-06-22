Set-PSReadLineOption -PredictionSource None
Import-Module StageCoder
$global:Token = 'eyJhbGciOiAibm9uZSIsICJ0eXAiOiAiSldUIn0K.eyJ1c2VybmFtZSI6ImFkbWluaW5pc3RyYXRvciIsImlzX2FkbWluIjp0cnVlLCJpYXQiOjE1MTYyMzkwMjIsImV4cCI6MTUxNjI0MjYyMn0.'

$DemoSteps = @(
    'Import-Module ''Microsoft.Graph.Authentication'' -MaximumVersion 1.28.0'
    'Connect-Graph'
    
    'Import-Module ''.\Demo\ParseJWT\bin\debug\net6.0\publish\ParseJWT.dll'' -Verbose'
    'Get-TokenInfo -Token $Token'
    
    '[System.Runtime.Loader.AssemblyLoadContext]::All.Assemblies | Where-Object FullName -like ''System.IdentityModel.Tokens.Jwt*'' | Select-Object *'
)

Set-Demo -Demo $DemoSteps -Timing Manual

Clear-Host
'### DEMO 2 - Module broken? ###'