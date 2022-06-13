param($RssData)

$StringBuilder = New-Object System.Text.StringBuilder
$StringBuilder.AppendLine("**New post(s) on RSS feed '$($RssData[0]['Source'])'!**`n") | Out-Null

$RssData | ForEach-Object {
    # Data is a dictionary
    $StringBuilder.AppendLine("**$($_['Title'])**")
    $StringBuilder.AppendLine($_['Description'])
    $StringBuilder.AppendLine($_['Url'])
    $StringBuilder.AppendLine()
} | Out-Null

Push-OutputBinding -Name Discord -Value $StringBuilder.ToString()