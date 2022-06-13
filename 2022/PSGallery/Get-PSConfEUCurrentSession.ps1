# Ensure we have the PSessionize module installed
# https://www.powershellgallery.com/packages/PSessionize
try {
    Import-Module PSessionize -ErrorAction Stop
}
catch {
    Install-Module PSessionize
}

# Get all sessions using the id of PSConfEU2022 and expand sessions info
$Sessions = (Get-SessionizeSession -Id 'dothvubr')[0] | Select-Object -ExpandProperty sessions

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