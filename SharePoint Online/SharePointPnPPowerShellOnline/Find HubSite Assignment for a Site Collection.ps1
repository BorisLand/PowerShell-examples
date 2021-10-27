# using SharePointPnPPowerShellOnline 3.29.2101.0
# How do you find the assigned Hubsite using PowerShell

$userName = "<admin account>"
$Password = "<password>"

$cred = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $userName, $(convertto-securestring $Password -asplaintext -force)

Connect-PnPOnline -Url https://<tenant>-admin.sharepoint.com/ -Credentials $cred

$url = "<your site collection url>"

$hubsites = Get-PnPHubSite

do {

    $url = Read-Host -Prompt 'Input Site Url'

    foreach($hubsite in $hubsites)
    {
        $sites = Get-PnPHubSiteChild -Identity $hubsite.SiteUrl
        # example: $sites = Get-PnPHubSiteChild -Identity https://tenant.sharepoint.com/sites/<hubsite url>
        $search = $sites | Where-Object { return $_ -eq $url}
        if($search -ne $null)
        {
            Write-Host "current hubsite configuration " $hubsite.Title -ForegroundColor Green
            break
        }
    }
} while($url -ne '')
