# Variables
$test = ""
​
# Array
$test = @("A","B","C")
​
# Array in Array
$test =
@(
    @("A","B","C"),
    @("D","E","F")
)
​
# Hash-Table
$test = 
@{
    (1,2,3),
    (4,5,6)
}
​
# ArrayList
$test = [System.Collections.ArrayList]@('1')
$test.Add('2')
​
# Function with Parameters
function UploadFiles
{
    param($webURL, $SourceFolder, $folderRelativeUrl)
    ...
    code
    ....
}
​
#Function with Mandatory Parameters
function UploadFiles
{
    param(
    [Parameter(Mandatory = $true)]
    $url
    )
    ...
    code
    ...
)
​
# Try Catch
try
{
    $x = 1/0
}
catch
{
    Write-Host $_.Exception.StackTrace
    Write-Host $_.Exception.Message
    Write-Host $_.Exception.InnerException.StackTrace
    Write-Host $_.Exception.InnerException.Message
}