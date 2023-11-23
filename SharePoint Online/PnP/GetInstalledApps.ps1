$clientId = "<clientid>"
$thumbprint = "<thumbprint>"
$tenant = "<tenant>"
$searchAppName = "PnP Modern Search - Search Web Parts - v4"

$tenantURI = "$($tenant).onmicrosoft.com"

$searchUrlStartWith = "https://$($tenant).sharepoint.com"

$rootURL = "https://$($tenant)-admin.sharepoint.com"
Connect-PnPOnline -Url $rootURL -ClientId $clientId -Thumbprint $thumbprint -Tenant $tenantURI
$allSites = Get-PnPTenantSite
Disconnect-PnPOnline

Write-Host "check $($allsites.Length) sites"

foreach($site in @($allsites))
{
    if($site.Url.StartsWith($searchUrlStartWith))
    {
        # $site = @($allsites)[2]
        Connect-PnPOnline -Url $site.Url -ClientId $clientId -Thumbprint $thumbprint -Tenant $tenantURI
        $app = Get-PnPApp -Identity $searchAppName
        if($null -ne $app.InstalledVersion)
        {
            Write-Host "$($site.Url)"
        }
        Disconnect-PnPOnline
    }
}
