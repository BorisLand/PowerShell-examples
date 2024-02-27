#
# Connect-PnPOnline -Url "https://<tenant>.sharepoint.com/sites/<sitecollection>"


Function Download-SPOFolder($FolderRelativeURL, $DestinationFolder)
{ 
    #Get the Folder's Site Relative URL
    $Folder = Get-PnPFolder -Url $FolderRelativeURL
    $FolderURL = $Folder.ServerRelativeUrl.Substring($Folder.Context.Web.ServerRelativeUrl.Length)
    $LocalFolder = $DestinationFolder + ($FolderURL -replace "/","\")
    #Create Local Folder, if it doesn't exist
    If (!(Test-Path -Path $LocalFolder)) {
            New-Item -ItemType Directory -Path $LocalFolder | Out-Null
            Write-host -f Yellow "Created a New Folder '$LocalFolder'"
    }

    #Get all Files from the folder
    $FilesColl = Get-PnPFolderItem -FolderSiteRelativeUrl $FolderURL -ItemType File
    #Iterate through each file and download
    Foreach($File in $FilesColl)
    {
        Get-PnPFile -ServerRelativeUrl $File.ServerRelativeUrl -Path $LocalFolder -FileName $File.Name -AsFile -force
        Write-host -f Green "`tDownloaded File from '$($File.ServerRelativeUrl)'"
    }

    #Get Subfolders of the Folder and call the function recursively
    $SubFolders = Get-PnPFolderItem -FolderSiteRelativeUrl $FolderURL -ItemType Folder
    Foreach ($Folder in $SubFolders | Where {$_.Name -ne "Forms"})
    {
        Download-SPOFolder $Folder.ServerRelativeUrl $DestinationFolder
    }
} 

Download-SPOFolder "/sites/<sitecollection>/clientsideassets" "C:\Temp\downloadFolder"
