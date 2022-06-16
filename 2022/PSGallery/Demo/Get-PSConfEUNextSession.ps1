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
# Filter the already sorted sessions by those not yet started, group by starttime and expand the first group
$Sessions = $Sessions | Where-Object {
    $Date -lt $_.startsAt
} | Group-Object startsAt | Select-Object -First 1 -ExpandProperty Group

# Output the title, speakers and description of the sessions
return $Sessions | Select-Object room,title,@{ n = 'speakers'; e = { $_.speakers.name -join ', ' } },description