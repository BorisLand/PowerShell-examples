# adding an existiting O365 Group to an existing site

Connect-SPOService -Url https://<tenant>-admin.sharepoint.com

$suffix = "<group name>"
Set-SPOSiteOffice365Group -Site "https://<tenant>.sharepoint.com/sites/$($suffix)" -Alias "$($suffix)" -DisplayName "$($suffix)"
