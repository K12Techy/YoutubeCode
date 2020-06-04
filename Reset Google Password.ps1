
#What you would like to set the password to.
$NewPassword ="password"

#Users email address to have password reset. 
$Email = "user@domain"

#Hold any errors that we get. 
$ErrorList = @() 

# This resets the password for the user and stores the success message in $Msg expamle of output is below. 
#
#Msg = updating user user@domain...

$Msg = (gam update user $Email password $NewPassword ) 

#
#This gives us the error message stored into the array we initized at the beginning. 
#
if($Error){
    
    # Example of what Error[0] would hold below if an error occured. 
    # Error[0] = ERROR: 404: Resource Not Found: userKey - userNotFound
    $ErrorList += ($Error[0].ToString() + $Email)
    
    # I would only do this if I was looping though a list of emails. 
    $Error.Clear()
 }
    
   
    
  