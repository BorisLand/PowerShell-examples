# How to migrate one Site with ShareGate PowerShell

# import ShareGate Module
Import-Module ShareGate

# source credentials
$userNameSource = "<source user account>"
$userPasswordSource = "<source user apssword>"
$credSource = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $userNameSource, $(convertto-securestring $userPasswordSource -asplaintext -force)

# destination credentials
$userNameDestination = "<destination user account>"
$userPasswordDestination = "<destination user password>"
$credDestination = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $userNameDestination, $(convertto-securestring $userPasswordDestination -asplaintext -force)

$copysettings = New-CopySettings -OnContentItemExists IncrementalUpdate # add or remove IncrementalUpdate

$mappingSettings = New-MappingSettings
$mappingSettings = Set-UserAndGroupMapping -MappingSettings $mappingSettings -UnresolvedUserOrGroup -Destination $userNameDestination

$srcSite = Connect-Site -Url $row.source -Credential $credSource
$dstSite = Connect-Site -Url $row.destination -Credential $credDestination

$taskName = ('PowerShell Copy "{0}" to "{1}" started' -f $srcSite.Title,$dstSite.Title)

$sesult = Copy-Site -Site $srcSite -DestinationSite $dstSite -TaskName $taskName -WaitForImportCompletion -MappingSettings $mappingSettings -CopySettings $copysettings

Export-Report $result -Overwrite -Path "c:\...\result.xlsx"
