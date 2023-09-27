# Variables
$test = ""

# Json
$json = @{ "xxx" = @("bbb","yyy","xxx")}
# get string
$str = ConvertTo-Json -InputObject $json
# get json
$json1 = ConvertFrom-Json -InputObject $str
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

# Date / Date Time
Get-Date
# => Mittwoch, 1. September 2021 10:07:07

Get-Date -Format "o"
# => 2021-09-01T10:08:52.4983856+02:00

Get-Date -Hour 0 -Minute 0 -Second 0
# => Mittwoch, 1. September 2021 00:00:00

# single quotes in text
$text = "my `"test`" text"
# => my "test" text

# wait from - to (sleep)
$now = Get-Date
$from = Get-Date -Hour 18 -Minute 00 -Second 00
$to = Get-Date -Hour 6 -Minute 00 -Second 00
do
{
    if(($now) -le ($from) -and ($now) -gt ($to))
    {
        Write-Host "."
        sleep -Seconds 600
    }
}
While(($now) -le ($from) -and ($now) -gt ($to))

# => Regex
# Match
$value | %{$_ -match '[*+„“!\r‘‘;%#]'}

# Replace
$SP_Value = $SP_Value | %{$_ -replace '[/r]'}

