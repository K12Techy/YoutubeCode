

function Move-ExpiredADUsers
{
  [CmdletBinding()]
    [Alias()]
    
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        $SourceOU = "OU=Users,DC=Domain,DC=com" ,
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=1)]
        $TargetOU ="OU=Old Users,OU=OLD ACCOUNTS,DC=Domain,DC=com",
        [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=2)]
        $Days = 180

        
        
    )

 
    Begin
    {
        
        $Users = Get-AdUser -filter * -SearchBase $SourceOU -SearchScope Subtree -Properties DistinguishedName,PasswordLastSet,lastLogonDate,PasswordNeverExpires
        
        $Users = $Users|Where-Object {
                $_.PasswordNeverExpires -eq $false -and $_.PasswordLastSet -lt (Get-Date).AddDays(-$Days)
            }
        $ObjectMoved = @()
    }

    Process
    {
        ForEach($User in $Users ) {
  
            $objectMoved += $User|Select-Object DistinguishedName,PasswordLastSet,lastLogonDate 
            $User |Move-ADObject -TargetPath $TargetOU
       
        }
        
       
    }

    End
    {
        return $objectMoved
    }
}
