﻿#By CSS ERW 14 Sept 2013  
#This script create DNS A Record and associate Reverse PTR 
#If Reverse Zone doesn't exist script create it 
#Create records.csv file with Computer,IP information 
#see example below add first line to your csv file 
# 
#Computer,IP 
#Computer,192.168.0.1 
#Computer1,192.168.0.2 
#Computer2,192.168.0.3 
# 
#Change with your dns server info $Servername and $Domain 
$ServerName = "atll-dc-01.lab.adms.local" 
$domain = "lab.adms.local" 
Import-Csv DNS.csv | ForEach-Object { 
 
#Def variable 
$Computer = "$($_.Computer).$domain" 
$addr = $_.IP -split "\." 
$rzone = "$($addr[2]).$($addr[1]).$($addr[0]).in-addr.arpa" 
 
#Create Dns entries 
 
dnscmd $Servername /recorddelete $domain "$($_.Computer)" A "$($_.IP)" 
 
#Create New Reverse Zone if zone already exist, system return a normal error 
#dnscmd $Servername /zoneadd $rzone /primary 
 
#Create reverse DNS 
dnscmd $Servername /recorddelete $rzone "$($addr[3])" PTR $Computer /f
}