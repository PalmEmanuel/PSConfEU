function Get-PSConfEUSession {
    param (
        [ValidateSet('Current', 'Next', 'All')]
        [string]$SessionFilter = 'All'
    )
    
    # Get all PSConfEU2022 sessions and expand sessions info
    $Sessions = Invoke-RestMethod 'https://psconfeu2022.sessionize.com/API/schedule' | Select-Object -ExpandProperty sessions

    $Date = Get-Date

    switch ($SessionFilter) {
        'Current' {
            # Filter sessions by those that are ongoing right this moment
            $Sessions = $Sessions | Where-Object {
                $Date -ge $_.startsAt -and
                $Date -lt $_.endSat
            }
            if ($Sessions.Count -eq 0) {
                Write-Warning 'There are no sessions currently going on!'
            }
        }
        'Next' {
            # Filter the already sorted sessions by those not yet started, group by starttime and expand the first group
            $Sessions = $Sessions | Where-Object {
                $Date -lt $_.startsAt
            } | Group-Object startsAt | Select-Object -First 1 -ExpandProperty Group
        }
    }

    # Output the title, speakers and description of the sessions
    return $Sessions | Select-Object room, title, @{ n = 'speakers'; e = { $_.speakers.name -join ', ' } }, description
}