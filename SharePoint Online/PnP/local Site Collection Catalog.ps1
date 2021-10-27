# using PnP.PowerShell 1.8.0
# search webpart / SPFx in all local site collection catalogs

$login = Read-Host "Enter your Login"
$pswd = Read-Host "Enter a Password" -AsSecureString
$cred = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $login, $(convertto-securestring $pswd -asplaintext -force)

# get all local site callection catalogs
Connect-PnPOnline -Url "https://<tenant>.sharepoint.com/sites/app-catalog" -Credentials $cred -WarningAction Ignore
$items = Get-PnPListItem -List "Lists/SiteCollectionAppCatalogs"
Disconnect-PnPOnline

# search webpart in all existing site collection catalogs
$searchWPName = "Accordion" # add webpart search text
foreach($item in @($items))
{
    Connect-PnPOnline -Url $item.FieldValues["SiteCollectionUrl"] -Credentials $cred -WarningAction Ignore
    $SPPKGitems = Get-PnPListItem -List "AppCatalog" -ErrorAction Ignore
    $sppkgExists = ($SPPKGitems | Where-Object { $_.FieldValues["Title"].Contains($searchWPName) }).Count -gt 0
    if($sppkgExists)
    {
        Write-Output "App $($searchWPName) exists on $($item.FieldValues["SiteCollectionUrl"])"
    }
    Disconnect-PnPOnline
}