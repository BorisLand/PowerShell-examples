# destination credentials
$userNameDestination = "<user account>"
$userPasswordDestination = "<password>"
$credDestination = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $userNameDestination, $(convertto-securestring $userPasswordDestination -asplaintext -force)
​
$url = "<site collection url>"
​
$CurrentDir = $(Get-Location).Path
$FileName = '<excel file>.xlsx'
​
$objExcel=New-Object -ComObject Excel.Application
$objExcel.Visible=$false
$WorkBook=$objExcel.Workbooks.Open(('{0}\{1}' -f $CurrentDir,$FileName ))
​
$worksheet = $WorkBook.sheets.Item(1)
​
# loop for each row of the excel file
$intRowMax = ($worksheet.UsedRange.Rows).count
​
Connect-PnPOnline -Url $url -Credentials $credDestination
​
#$intRowMax = 3 # for testing
for($intRow = 2 ; $intRow -le $intRowMax ; $intRow++)
{
    $values = @{
        "Medium"= $worksheet.cells.item($intRow,1).value2;
        
        # all columns        
        #"value1"= $worksheet.cells.item($intRow,2).value2;
        #"value2"= $worksheet.cells.item($intRow,3).value2;
        #"value3"= $worksheet.cells.item($intRow,4).value2;
    }    
    Write-Host "." -NoNewline
​
    $item = Add-PnPListItem -List "<sharepoint list title>" -Values $values    
}
Disconnect-PnPOnline
​
$WorkBook.close()
$objexcel.quit()