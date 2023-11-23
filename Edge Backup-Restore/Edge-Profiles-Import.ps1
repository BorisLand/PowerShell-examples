Write-Host "Backup folder path:"
$backupPath = Read-Host

$backupFolder = Get-Item -Path $backupPath
if($null -eq $backupFolder)
{
    Write-Host "Backup folder does not exists! $($backupPath)" -ForegroundColor Red
    break;
}

taskkill /f /IM msedge.exe
taskkill /f /IM msedgewebview2.exe

$path = "$($env:LOCALAPPDATA)\Microsoft\Edge\User Data"
$profileFolders = Get-ChildItem -Path $backupFolder -Directory

Copy-Item -Path "$($backupPath)\Local State" -Destination $path
$ErrorActionPreference= 'silentlycontinue'
foreach($folder in @($profileFolders))
{
    # $folder = @($profileFolders)[0]
    $destPath = "$($path)\$($folder.Name)"
    Write-Host "Import folder $($folder.FullName) to $($destPath)"
    Copy-Item -Path "$($folder.FullName)" -Destination "$($destPath)" -Force -Recurse

    Write-Host "Import registry "
    $regFileName = "$($backupPath)\Pref_$($folder.Name).reg"
    reg import "$($regFileName)"
    $regFileName = "$($backupPath)\Pro_$($folder.Name).reg"
    reg import "$($regFileName)"
}