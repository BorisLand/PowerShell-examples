Write-Host "Backup folder path:"
$backupPath = Read-Host

$backupFolder = Get-Item -Path $backupPath
if($null -eq $backupFolder)
{
    Write-Host "Backup folder does not exists! $($backupPath)" -ForegroundColor Red
    break;
}
New-Item -Path $backupPath -ItemType Directory -ErrorAction Ignore

$backupFolder = Get-Item -Path $backupPath

$path = "$($env:LOCALAPPDATA)\Microsoft\Edge\User Data"
$profileFolders = Get-ChildItem -Path $path -Filter "Profile*"
$defaultFolders = Get-ChildItem -Path $path -Filter "Default"

$profileFolders = $profileFolders + $defaultFolders
foreach($profile in @($profileFolders))
{
    # $profile = @($profileFolders)[1]
    $destPath = "$($backupFolder.FullName)\$($profile.Name)"
    Write-Host "Backup folder $($profile.FullName) to $($destPath)"

    New-Item -Path "$($destPath)" -ItemType Directory -ErrorAction Ignore

    Copy-Item -Path "$($profile.FullName)/*" -Destination "$($destPath)" -Force -Exclude @("Service Worker","Cache","Code Cache")
    
    $regHKEY = "HKEY_CURRENT_USER\Software\Microsoft\Edge\Profiles\$($profile.Name)"
    $regFileName1 = "$($backupPath)\Pro_$($profile.Name).reg"
    Write-Host "Backup registry $($regHKEY) to $($destPath)"
    
    reg export $regHKEY $regFileName1 /y

    $regHKEY = "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Edge\PreferenceMACs\$($profile.Name)"
    $regFileName2 = "$($backupPath)\Pref_$($profile.Name).reg"
    reg export $regHKEY $regFileName2 /y

    $localStateFilePath = "$($path)\Local State"
    Copy-Item -Path $localStateFilePath -Destination $backupPath
}