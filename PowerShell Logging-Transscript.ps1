# PowerShell Logging / Transscript
# Generating a log file and store the output consoles

# remove all logfiles older than 30 days
Get-ChildItem –Path "." -Recurse | Where-Object {($_.Name.StartsWith('logfile') -and $_.LastWriteTime -lt (Get-Date).AddDays(-30))} | Remove-Item
​
# set logfile name
$global:logFileName = "./logfile-"+(Get-Date).ToString('dd-MM-yyyy')+".log"
​
Start-Transcript -Path $global:logFileName -Append
​
Write-Host "Hello World"
​
Stop-Transcript