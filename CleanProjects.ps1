cd C:\DevGit

$allDirTemp = @(Get-ChildItem -Directory -Filter 'temp' -Recurse)
foreach($folder in @($allDirTemp))
{
    # $folder = @($allDirTemp)[0]
    Write-Host "Remove $($folder.FullName)"
    Remove-Item -Path $folder.FullName -Force -Confirm:$false -Recurse
}

$allDirNodeModules = @(Get-ChildItem -Directory -Filter 'node_modules' -Recurse)
foreach($folder in @($allDirTemp))
{
    # $folder = @($allDirTemp)[0]
    Write-Host "Remove $($folder.FullName)"
    Remove-Item -Path $folder.FullName -Force -Confirm:$false -Recurse
}
