<#
.Synopsis
   Change the Default Port from your RDP and Create a new Rule in your local Windows Firewall with Name "Allow RDP in Custom Port"
.DESCRIPTION
   This script changes the Default port For RDP (3389 TCP) for security reasons, also creates a rule in your windows firewall with the name "Allow RDP in Custom Port".
   If the script is run several times: the 1st time will create the rule, and the next ones will update the rule.

.EXAMPLE
   .\SetRDPPort
   It's the default behavior it will report the actual port and if you want to change it or not.
   Then will do a validation of the port number
   after that, it will create do the change and create the rule in firewall.
   And Finally will ask you if you want to reboot the computer (so the changes made efect)

.EXAMPLE
   .\SetRDPPort -NewRDPPort 4389
   Change the RDP port and create a rule for the Port 4389
   and Ask if you want to reboot the server or computer now.

#>
[CmdletBinding()]
param(
    [Parameter(position=0,mandatory=$false,Valuefrompipeline=$true)][string]$NewRDPPort
)

Clear-Host
$ActualNumber = (Get-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp').Portnumber

if($NewRDPPort){
    write-output "The Actual TCP-Port Number for your RDP is: $ActualNumber"
    write-output "New RDP Port Provide with number $NewRDPPort"


    $Newport= $NewRDPPort
    if(!($NewPort -match "^\d+$" -and $NewPort -gt 0 -and $NewPort -le 65535)){
        Write-Warning "Please select a number between 1-65535. Make sure that the port is not used by another application, like DNS (21) or AD (389)"
        exit 0;
    }
}

else{
    $answer = Read-Host "The Actual TCP-Port Number for your RDP is: $ActualNumber port`nWould you like to change it (y/n)?" 
    switch ($answer){
        "y" {
            for(;;){
                $NewPort= Read-Host "`tWhat number you want to use for RDP (1-65535)?"
                if($NewPort -match "^\d+$" -and $NewPort -gt 0 -and $NewPort -le 65535){
                    break;
                }
                else{
                    Write-Warning "Please select a number between 1-65535. Make sure that the port is not used by another application, like DNS (21) or AD (389)"
                }
            }
        }
    }
}



try{
    Write-Output "`tSetting up new number TCP port for RDP to $NewPort"
    Set-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name Portnumber -Value $NewPort   -ErrorAction Stop
    $str="'$NewPort'"
    $isAlreadyCreated = if (Get-NetFirewallRule | where { $_.DisplayName -eq "Allow RDP in Custom Port"}){$true}
    if(!($isAlreadyCreated)){
        New-NetFirewallRule -DisplayName 'Allow RDP in Custom Port' -Profile @('Domain', 'Private','Public') -Direction Inbound -Action Allow -Protocol TCP -LocalPort @($NewPort)
    }
    else{
        Set-NetFirewallRule -DisplayName 'Allow RDP in Custom Port' -Profile @('Domain', 'Private','Public') -Direction Inbound -Action Allow -Protocol TCP -LocalPort @($NewPort)
    }
    
    $ActualNumber = (Get-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp').Portnumber
    Write-Host "`tSuccess" -ForegroundColor Green
    Write-Host "`tThe Number for RDP is $ActualNumber" -ForegroundColor Cyan
}
catch{
    $ErrorMessage = $_.Exception.Message
    Write-Error "Failed!`n Message: $ErrorMessage `n"
    Write-Warning "Make sure that you're running the script as administrator to gain access to the registry"
    exit -1
}

Write-Warning "For the changes to take effect is required to reboot the computer"
$read = Read-Host "Would you like to do it now (y/n): ?"
switch($read){
    "y" {Restart-Computer}
}
