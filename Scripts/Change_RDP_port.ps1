#Pre-Defineed RDP Port Value
Write-host ""
$Custom_RDPPort="44211"
Write-host “Making Changes in registry..." -ForegroundColor DarkGray -NoNewline
Write-host "Done" -ForegroundColor Gray
Write-host ""
##
Set-ItemProperty -Path “HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-TCP\” -Name PortNumber -Value $Custom_RDPPort
Write-host “Adding Firewall Rule..." -ForegroundColor DarkGray  -NoNewline
Write-host "Done" -ForegroundColor Gray
Write-host ""
##
New-NetFirewallRule -DisplayName “RDP Custom Port” -Direction Inbound –LocalPort $Custom_RDPPort -Protocol TCP -Action Allow | Out-Null
Write-host "New RDP Port is :  " -ForegroundColor Yellow -NoNewline
Write-host  $Custom_RDPPort -BackgroundColor Red  -NoNewline
Write-host ""
Write-host ""
