###############################################################
# Bulk_Check_AD_Credentials_v1.0.ps1
# Version 1.0
# MALEK Ahmed - 31 / 03 / 2013
###################

##################
#--------Function 
##################
Function Test-ADAuthentication {
    param($userlogin,$userpassword)
    (new-object directoryservices.directoryentry "",$userlogin,$userpassword).psbase.name -ne $null
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