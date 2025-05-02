# Change server name
Rename-Computer -NewName "AD-SERVER" -Force -Restart

# Setting static IP
New-NetIPAddress -IPAddress 192.168.1.100 -PrefixLength 24 -InterfaceIndex (Get-NetAdapter).InterfaceIndex
Set-DnsClientServerAddress -ServerAddresses 192.168.1.100