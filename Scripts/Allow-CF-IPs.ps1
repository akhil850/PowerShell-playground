$IPv4s = (Invoke-WebRequest -Uri "https://www.cloudflare.com/ips-v4").Content.TrimEnd([Environment]::NewLine).Split([Environment]::NewLine);
$IPv6s = (Invoke-WebRequest -Uri "https://www.cloudflare.com/ips-v6").Content.TrimEnd([Environment]::NewLine).Split([Environment]::NewLine);
New-NetFirewallRule -DisplayName 'cloudflare-Ipv4' -Profile @('Domain', 'Private','Public') -Direction Inbound -Action Allow
$name1 = Get-NetFirewallrule -DisplayName "cloudflare-Ipv4"

foreach($r1 in $name1)
{
    Set-NetFirewallRule -DisplayName $r1.DisplayName -RemoteAddress $IPv4s
}
#Set_2
New-NetFirewallRule -DisplayName 'cloudflare-Ipv6' -Profile @('Domain', 'Private','Public') -Direction Inbound -Action Allow
$name2 = Get-NetFirewallrule -DisplayName "cloudflare-Ipv6"
foreach($r2 in $name2)
{
    Set-NetFirewallRule -DisplayName $r2.DisplayName -RemoteAddress $IPv6s
}
