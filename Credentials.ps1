
$cred = Get-Credential -UserName "<add your UPN>" -Message "Enter your Office 365 credentials";

# or

$login = "<add your UPN>";
$pswd = "<add your password>";
$pswd = ConvertTo-SecureString $pswd -AsPlainText -Force;
$cred = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $login,$pswd;

# or

$login = "<user account>"
$pswd = "<password>"
$cred = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $login, $(convertto-securestring $pswd -asplaintext -force)

# or 
$login = Read-Host "Enter your Login"
$pswd = Read-Host "Enter a Password" -AsSecureString
$cred = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $login, $(convertto-securestring $pswd -asplaintext -force)
