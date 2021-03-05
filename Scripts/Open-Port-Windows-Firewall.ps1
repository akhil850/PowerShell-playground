#Ref : https://docs.microsoft.com/en-us/powershell/module/netsecurity/new-netfirewallrule?view=win10-ps

#Open Port
New-NetFirewallRule -DisplayName 'Test Port 1234' -Profile 'Private','Domain','Public' -Direction Inbound -Action Allow -Protocol TCP -LocalPort 2002
New-NetFirewallRule -DisplayName "Test Port 1234" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 2002 -RemoteAddress 1.1.1.1
New-NetFirewallRule -DisplayName "Test Port 2002" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 2002,2003


#Block Port
New-NetFirewallRule -DisplayName "Test Port 1234" -Direction Inbound -Action block -Protocol TCP -LocalPort 2002 -
