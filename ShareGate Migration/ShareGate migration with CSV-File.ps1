# Migration from SharePoint xxx to SharePoint Online with CSV-File

# CSV-File:
# ---------
# source;destination;migration;incremental;migrateSubSites;logoUrl
# <source url>;<destination url>;true;true;true;<destination logo>
# https://<onpremise fqdn>/<web url>;https://<tenant>.sharepoint.com/<site colltion url>;true;true;true;<url to central logo>

function logging
{
    param(
        [Parameter(Mandatory = $true)]
        $logFilePath,
        [Parameter(Mandatory = $true)]
        $text,
        [Parameter(Mandatory = $true)]
        $ForegroundColor
    )
​
    Write-Host $text -ForegroundColor $ForegroundColor
    Add-Content -Path $logFilePath  -Value $text
}
​
$delimiter = ';'
$csvFileName = 'Migration.csv'
$CurrentDir = $(Get-Location).Path
​
# logfile
$currentDate = (Get-Date).ToString('dd-MM-yyyy')
$logFileName = ('{0}\migration-{1}.log' -f $CurrentDir,$currentDate)
# source credentials
$userNameSource = "<source user account>"
$userPasswordSource = "<source user apssword>"
$credSource = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $userNameSource, $(convertto-securestring $userPasswordSource -asplaintext -force)
​
# destination credentials
$userNameDestination = "<destination user account>"
$userPasswordDestination = "<destination user password>"
$credDestination = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $userNameDestination, $(convertto-securestring $userPasswordDestination -asplaintext -force)
​
# import ShareGate Module
Import-Module ShareGate
​
$content = Import-CSV ('{0}\{1}' -f $CurrentDir,$csvFileName ) -Delimiter $delimiter
​
# ShareGate Settings
$copysettings = New-CopySettings -OnContentItemExists IncrementalUpdate
​
foreach($row in $content)
{
    Write-Host $row -ForegroundColor Yellow
​
    if($row.migration -eq $true)
    {
        logging -logFilePath $logFileName -text ('Migration "{0}" to "{1}" started' -f $row.source,$row.destination) -ForegroundColor Yellow
​
        $srcSite = Connect-Site -Url $row.source -Credential $credSource
        $dstSite = Connect-Site -Url $row.destination -Credential $credDestination
​
        $mappingSettings = New-MappingSettings
        $mappingSettings = Set-UserAndGroupMapping -MappingSettings $mappingSettings -UnresolvedUserOrGroup -Destination $userNameDestination
​
        $incrementalText = ''
        if($row.incremental -eq $true)
        {
            $incrementalText = 'incremental'
        }
        $taskName = ('PowerShell Copy {2} "{0}" to "{1}" started' -f $srcSite.Title,$dstSite.Title,$incrementalText)
        
        logging -logFilePath $logFileName -text ('Task: "{0}"' -f $taskName) -ForegroundColor Yellow
​
        # shareGate migration
        if($row.incremental -eq $true)
        {
            if($row.migrateSubSites -eq $false)
            {
                Copy-Site -Site $srcSite -DestinationSite $dstSite -TaskName $taskName -WaitForImportCompletion -MappingSettings $mappingSettings -CopySettings $copysettings
            }
            else
            {
                Copy-Site -Site $srcSite -DestinationSite $dstSite -Subsites -TaskName $taskName -WaitForImportCompletion -MappingSettings $mappingSettings -CopySettings $copysettings
            }
        }
        else
        {
            if($row.migrateSubSites -eq $false)
            {
                Copy-Site -Site $srcSite -DestinationSite $dstSite -Merge -TaskName $taskName -WaitForImportCompletion -MappingSettings $mappingSettings
            }
            else
            {
                Copy-Site -Site $srcSite -DestinationSite $dstSite -Merge -Subsites -TaskName $taskName -WaitForImportCompletion -MappingSettings $mappingSettings
            }
        }
        logging -logFilePath $logFileName -text ('done') -ForegroundColor Green
​
    }
    else
    {
        logging -logFilePath $logFileName -text ('no migration "{0}" to "{1}"' -f $row.srcSite,$row.destSite) -ForegroundColor Orange
    }
}