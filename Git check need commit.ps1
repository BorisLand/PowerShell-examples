# go to your local git folder
$rootPath = "C:\DevGit"
cd $rootPath

$allDir = @(Get-ChildItem -Directory)
foreach($companyFolder in @($allDir))
{
    # $companyFolder = @($allDir)[0]
    Write-Host $companyFolder.Name
    cd $($companyFolder.Name)
    $allGitDirs = @(Get-ChildItem -Directory)
    foreach($allGitDir in @($allGitDirs))
    {
        # $allGitDir = @($allGitDirs)[0]
        cd $($allGitDir.Name)
        $needCommit = git status --porcelain=v1
        if($needCommit -ne $null)
        {
            Write-Host $allGitDir.FullName
        }
        else
        {
            Write-Host "$($allGitDir.FullName) > OK" -ForegroundColor Green
        }
        cd ..
    }
    cd ..
}
