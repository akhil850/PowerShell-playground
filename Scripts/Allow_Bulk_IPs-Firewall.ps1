New-NetFirewallRule -DisplayName 'Allowed IPs Rule' -Profile @('Domain', 'Private','Public') -Direction Inbound -Action Allow
$rulename = Get-NetFirewallrule -DisplayName "Allowed IPs Rule"
$ips_list = @("ADD_CIDR_RANGE",
"ADD_CIDR_RANGE",
"ADD_CIDR_RANGE",
"ADD_CIDR_RANGE")

foreach($r1 in $rulename)
{
    Set-NetFirewallRule -DisplayName $r1.DisplayName -RemoteAddress $ips_list
}
