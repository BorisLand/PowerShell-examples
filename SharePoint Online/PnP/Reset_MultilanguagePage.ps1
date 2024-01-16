$clientId = "xxx"
$thumbprint = "xxx"
$tenant = "xxx.onmicrosoft.com"

$url = "https://xxx.sharepoint.com/sites/xxx"
$fileName = "xxx.aspx"
$fileUrl = "/SitePages/$($filename)"

$languageToRemove = "de-de"

Connect-PnPOnline -Url $url -ClientId $clientId -Thumbprint $thumbprint -Tenant $tenant

$currentPageListItem = Get-PnPFile -Url $fileUrl -AsListItem
if($null -ne $currentPageListItem) 
{
    $translatedLanguages = $currentPageListItem.FieldValues["_SPTranslatedLanguages"]
    $index = $translatedLanguages.IndexOf($languageToRemove)
    $translatedLanguages[$index] = $null

    $page = Get-PnPClientSidePage -Identity $fileName
    $translationsResult = $page.GetPageTranslations()
    $translationPage = $translationsResult.TranslatedLanguages | Where-Object { return $_.Culture -eq $languageToRemove }[0]

    Remove-PnPClientSidePage -Identity $translationPage.Path.Replace("SitePages/", "")
    
    Set-PnPListItem -List "/SitePages" -Identity $currentPageListItem.Id -Values @{"_SPTranslatedLanguages" = $translatedLanguages}
}