# SP2019: Change AllowMembersEditMembership for all Site Collection (by Filter) :

Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue
Import-Module SharePointPnPPowerShell2019 -Verbose
cls
​
$siteCollections = Get-SPWebApplication "<web application url>" | Get-SPSite -Limit ALL
foreach($siteCollection in @($siteCollections)){
    # filter your site collections
    if($siteCollection.Url -notlike "*sites/SitePrefix*")) # filter
    {
        Write-Host $siteCollection.Url
        Connect-PnpOnline -Url $siteCollection.Url -CurrentCredentials
        $web = Get-PnPWeb -Includes MembersCanShare, AssociatedMemberGroup.AllowMembersEditMembership
        $web.MembersCanShare=$false
        $web.AssociatedMemberGroup.AllowMembersEditMembership=$false
        $web.AssociatedMemberGroup.Update()
        $web.Update()
        $web.Context.ExecuteQuery()
        Disconnect-PnPOnline
    }
}