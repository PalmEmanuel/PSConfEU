# Get all PSConfEU2022 sessions and expand sessions info
$Sessions = Invoke-RestMethod 'https://psconfeu2022.sessionize.com/API/schedule' | Select-Object -ExpandProperty sessions

$Date = Get-Date
# Filter sessions by those that are ongoing right this moment
$Sessions = $Sessions | Where-Object {
    $Date -ge $_.startsAt -and
    $Date -lt $_.endSat
}
if ($Sessions.Count -eq 0) {
    Write-Warning 'There are no sessions currently going on!'
}

# Output the title, speakers and description of the sessions
return $Sessions | Select-Object room,title,@{ n = 'speakers'; e = { $_.speakers.name -join ', ' } },description