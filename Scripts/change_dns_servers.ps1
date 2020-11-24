$Adapters = Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object {$_.DHCPEnabled -ne 'True' -and $_.DNSServerSearchOrder -ne $null}

$Adapters | Set-DnsClientServerAddress -ServerAddresses "1.1.1.1","8.8.8.8"

Get-NetIPConfiguration
