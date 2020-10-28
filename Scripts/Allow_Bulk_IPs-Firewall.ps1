New-NetFirewallRule -DisplayName 'cloudflare-Ipv4' -Profile @('Domain', 'Private','Public') -Direction Inbound -Action Allow
$rulename = Get-NetFirewallrule -DisplayName "Allowed IPs Rule"
$ips_list = @("173.245.48.0/20",
"103.21.244.0/22",
"103.22.200.0/22",
"103.31.4.0/22",
"141.101.64.0/18",
"108.162.192.0/18",
"190.93.240.0/20",
"188.114.96.0/20",
"197.234.240.0/22",
"198.41.128.0/17",
"162.158.0.0/15",
"104.16.0.0/12",
"172.64.0.0/13",
"131.0.72.0/22")

foreach($r1 in $rulename)
{
    Set-NetFirewallRule -DisplayName $r1.DisplayName -RemoteAddress $ips_list
}
