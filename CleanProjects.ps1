﻿Write-Host "Local Git folder path (example 'c:\DevGit'):"
$gitfolderPath = Read-Host

$gitfolder = Get-Item -Path $gitfolderPath
if($null -eq $gitfolder)
{
    Write-Host "Folder does not exists! $($gitfolderPath)" -ForegroundColor Red
    break;
}

if((nvm current) -ne 'v16.15.1')
{
    nvm use 16.15.1
}
Write-Host "Install RimRaf"
npm install --location=global rimraf

cd $gitfolderPath

rimraf --glob node_modules **/node_modules
