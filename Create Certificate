Create Certificate:

New-SelfSignedCertificate -Subject "CN=<name>TestCert" -CertStoreLocation "Cert:\CurrentUser\My" -KeyExportPolicy Exportable -KeySpec Signature -NotAfter (Get-Date).AddYears(5)

# open certmgr.msc
# go to Certificates - Current User
# select Certificate => All Tasks => Export => Next .... => Export as .cer
# go to App Registration => Upload certifikate ".cer"

# go to Certificates - Current User
# select Certificate => All Tasks => Export => Next => select Yes, private key => Next => add Password .... => Export as .pfx
# Password example: 123
# go to Automation Account => certificates => Add a certificate => Upload .pfx
