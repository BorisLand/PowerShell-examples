# using SharePointPnPPowerShellOnline 3.29.2101.0
# Creating a SharePoint Team Site Modern without creation of an associated O365

$connection = Connect-PnPOnline -Url "https://<tenant>-admin.sharepoint.com/" -UseWebLogin -ReturnConnection

$NewModenTeamSite = @{
    Title = "<site title>"
    Url = "https://<tenant>.sharepoint.com/sites/<site collection url>"
    Owner = "<owner or admin account>"
    Lcid = 1031
    Template = "STS#3" # STS#3 Teamsite | SITEPAGEPUBLISHING#0 Communication site
    TimeZone = 4
    StorageQuota = 1024
}

New-PnPTenantSite @NewModenTeamSite -Connection $connection
