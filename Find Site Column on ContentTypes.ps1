Connect-PnPOnline -Url <URL>

$fieldName = "<fieldName>"
$web = Get-PnPWeb -Includes Fields,AvailableContentTypes
$sfield = get-pnpfield -Identity $fieldName

foreach($ct in @($web.AvailableContentTypes))
{
    $fields = Get-PnPProperty -ClientObject $ct -Property "Fields"
    foreach($field in @($fields))
    {
        if($field.Id -eq $sfield.Id)
        {
            Write-Host $ct.Name
        }
    }
}
