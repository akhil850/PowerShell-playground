#EXport list of installed IIS components to a CSV File
Get-WindowsFeature | where{$_.Installed -eq $True} | select name | Export-Csv C:\inetpub\IISRoles.csv -NoTypeInformation -Verbose

#Import from CSV
Import-Csv C:\inetpub\IISRoles.csv | foreach{Add-WindowsFeature $_.name  }
