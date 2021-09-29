# enable feature for each site collections an trigger contenthub subscriber

# 1. go to contenttypehub => https://<SP 2019 Url>/sites/contenttypehub
# 2. enable site collection feature "Site Policies"
# 3. go to /sites/contenttypehub/_layouts/15/ProjectPolicies.aspx and create new policy
#   Name: "MakeReadOnly"
#   Description: "...
#   Site Closure and Deletion: "Do not close or delete site automatically."
#   Site Collection Closure: enable checkbox "The site collection will be read only when it is closed."
# 4. run this script
# 5. go to /sites/contenttypehub/_layouts/15/ProjectPolicies.aspx and click "Manage publishing for this policy"
#


$credOnPremise = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist "<User>", $(convertto-securestring "<Password>" -asplaintext -force)

Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue

$siteCollections = Get-SPSite https://<SP 2019 url>/* -Limit all

foreach($site in @($siteCollections))
{
    # $site = @($siteCollections)[0]
    
    Write-Host $site.Url
    $sourceSiteConnection = Connect-PnPOnline -Url $site.Url -Credentials $credOnPremise -ReturnConnection
    $SitePolicyFeature = Get-PnPFeature -Identity "2fcd5f8a-26b7-4a6a-9755-918566dba90a" -Scope Site -Web $sourceUrl -Connection $sourceSiteConnection
    
    if($SitePolicyFeature.DefinitionId -eq $null)
    {
        #Activate "Site Policy" Feature for the site collection
        Write-Host "Activate Site Policy Feature at $($site.Url)" -ForegroundColor Green
        Enable-PnPFeature -Identity "2fcd5f8a-26b7-4a6a-9755-918566dba90a" -Scope Site -Connection $sourceSiteConnection
        #Write-Host "Site Policy Feature is Activated at $($site.Url)" -ForegroundColor Green
    }
    
    Set-PnPPropertyBagValue -key "metadatatimestamp" -value " " -Connection $sourceSiteConnection
    
    Disconnect-PnPOnline -Connection $sourceSiteConnection
}



