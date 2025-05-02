# AD-Setup.ps1
# Install Active Directory role
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# Create a domain
$DomainName = "laplateforme.io"
$SafeModePassword = ConvertTo-SecureString "SafeModePass123!" -AsPlainText -Force

Install-ADDSForest `
    -DomainName $DomainName `
    -DomainMode "WinThreshold" `
    -ForestMode "WinThreshold" `
    -InstallDns:$true `
    -SafeModeAdministratorPassword $SafeModePassword `
    -Force:$true

# After restart, run the following script
# Import-Module ActiveDirectory
# .\Create-UsersFromCSV.ps1