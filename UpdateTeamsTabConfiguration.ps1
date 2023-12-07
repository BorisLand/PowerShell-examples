# howto update Teams Tab Webpart properties
# in teams you have a tab that contains an SPFx web part

$url = "https://<tenant>.sharepoint.com/sites/<teams site collection>"
$webPartId = "<webpart id>"
Connect-PnPOnline -Url $url -Interactive

$items = Get-PnPListItem -List "Lists/HostedAppConfigs"

foreach($item in @($items))
{
    $content = $item.fieldValues["CanvasContent1"]
    $xml = [xml]$content
    $json = ConvertFrom-Json $xml.div.div.div.Attributes["data-sp-webpartdata"].Value

    if($json.id -eq $webPartId)
    {
        # Webpart property (in my code it is a PropertyFieldCollectionData property)
        $editMappingContent = Get-Content -Raw .\UpdateTeamsTabConfiguration_editmapping.json
        $editmapping = ConvertFrom-Json -InputObject $editMappingContent
        $json.properties.editMapping = $editmapping

        # Webpart property (in my code it is a PropertyFieldCodeEditor property)
        $htmlCode = Get-Content -Raw .\UpdateTeamsTabConfiguration_htmlCode.html
        $json.properties.htmlCode = $htmlCode

        # update item
        $xml.div.div.div.Attributes["data-sp-webpartdata"].Value =  ConvertTo-Json -InputObject $json -depth 3
        Set-PnPListItem -List "Lists/HostedAppConfigs" -Identity $item.Id -Values @{"CanvasContent1"= $xml.InnerXml}
    }
}