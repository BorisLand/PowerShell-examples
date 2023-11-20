# Credential Manager and Secure String
Install-Module -Name CredentialManager

Import-Module -Name CredentialManager

New-StoredCredential -Target "xxx" -UserName "abc" -Password "xyz" -Type Generic

$x = Get-StoredCredential -Target "xxx"
$password = $x.Password
$Ptr = [System.Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUnicode($password)
$result = [System.Runtime.InteropServices.Marshal]::PtrToStringUni($Ptr)
[System.Runtime.InteropServices.Marshal]::ZeroFreeCoTaskMemUnicode($Ptr)
$result
