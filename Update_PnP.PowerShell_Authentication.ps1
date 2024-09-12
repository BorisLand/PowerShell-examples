# install latest PnP.PowerShell Release > min. 2.12.0

$tenant = "xxx"

$rootURL = "https://$($tenant).sharepoint.com"
$tenantURL = "$($tenant).onmicrosoft.com"

Connect-PnPOnline -Url $rootURL -UseWebLogin

$newAppReg = Register-PnPEntraIDAppForInteractiveLogin -ApplicationName "PnP Interactive" -Tenant $tenantURL -Interactive

$clientId = $newAppReg.'AzureAppId/ClientId'

# test connection

$cred = Get-Credential

Connect-PnPOnline -Url $rootURL -Credentials $cred -ClientId $clientId

Get-PnPList