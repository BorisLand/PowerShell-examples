# using SharePointPnPPowerShellOnline 3.29.2101.0
# Change AllowMembersEditMembership for one Site Collection:

Connect-PnpOnline -Url "<site collection url>" -CurrentCredentials
$web = Get-PnPWeb -Includes MembersCanShare, AssociatedMemberGroup.AllowMembersEditMembership
$web.MembersCanShare = $false
$web.AssociatedMemberGroup.AllowMembersEditMembership = $false
$web.AssociatedMemberGroup.Update()
$web.Update()
$web.Context.ExecuteQuery()
Disconnect-PnPOnline
