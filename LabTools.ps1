
function _Capitalize {
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   Position=0)]
        [string]$inputString
    )

    Begin
    {
        Write-verbose " you entered $inputString"
    }
    Process
    {
        [string]$output = $inputString.substring(0,1).toupper() + $inputString.substring(1).tolower()
    }
    End
    {
        return $output
    }
}
<#
 .Synopsis
    Quick and dirty function to generate random user data for labs
 .DESCRIPTION
    Calls the randomuser.me api to get random user data and create users based off of the data
 .EXAMPLE
    Initialize-LabUser
 .EXAMPLE
    Initialize-LabUser -Count 50 -International
 #>
 function Initialize-LabUser {
     [CmdletBinding()]
     [Alias()]
     [OutputType([int])]
     Param
     (
         # Param1 help description
         [Parameter(Mandatory=$false,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
         [ValidateRange(1,5000)]
         [int]$Count = '1',

         [switch]$MultiSite

         

     )
 
     Begin
     {
        $OutputCollection = @()
        $seed = 'enpointe'
        Write-Verbose "Seed is hardcoded to $seed in this verstion of Initialize-LabUser"

        if (!($Multisite)){
            $country = 'US'
            $company = "Enpointe R&D Labs"

            Write-Verbose "Collecting user data for $count users to be located in the USA"
            $randomusers = Invoke-RestMethod -Uri "http://api.randomuser.me/?inc=name,location,phone,cell&results=$count&seed=$seed&nat=us"
            }

         else {
            Write-Verbose "Collecting user data for $count users to be located internationally"
            $randomusers = Invoke-RestMethod -Uri "http://api.randomuser.me/?inc=name,location,phone,cell&results=$count&seed=$seed&nat=us,gb,fr,au,nz,dk"
         }
     }
     Process
     {
        ForEach($result in $randomusers.results){
        $result.name.first.substring(0,1) = $result.name.first.toUpper()
        $outputObject = "" | Select GivenName, LastName, Street, City, State, PostCode, Country, Phone, Cell
        $outputObject.GivenName = (Get-Culture).TextInfo.ToTitleCase($result.name.first)
        $outputObject.LastName  = (Get-Culture).TextInfo.ToTitleCase($result.name.last)
        $outputObject.Street = (Get-Culture).TextInfo.ToTitleCase($result.location.street)
        $outputObject.City = (Get-Culture).TextInfo.ToTitleCase($result.location.city)
        $outputObject.State = (Get-Culture).TextInfo.ToTitleCase($result.location.state)
        $outputObject.PostCode = $result.location.postcode
        $outputObject.Country = 'US'
        $outputObject.Phone = $result.phone
        $outputObject.Cell = $result.cell
        
        $OutputCollection += $outputObject
        }
        # regen usernames
        #Write-verbose "test"
        # regen addresses
     }
     End
     {
          return $OutputCollection
     }
 }

 <#
 .Synopsis
    Short description
 .DESCRIPTION
    Long description
 .EXAMPLE
    Example of how to use this cmdlet
 .EXAMPLE
    Another example of how to use this cmdlet
 #>
 function New-LabUser {
     [CmdletBinding()]
     [Alias()]
     [OutputType([int])]
     Param
     (
         # Param1 help description
         [Parameter(Mandatory=$true,
                    ValueFromPipeline=$true,
                    Position=0)]
         
         $InputObject,
 
         # Param2 help description
         [string]$OU = 'OU=Test,DC=pheo,DC=org'
     )
 
     Begin
     {
       # if (!($OU)){
       # $OU = (Get-ADDomain).UsersContainer
       # }
       $password = 'Somepass1' | ConvertTo-SecureString -AsPlainText -Force
     }
     Process
     {
        ForEach($user in $InputObject){
            $accountname = "$($user.givenname).$($user.lastname)"
            #hash table for splat New-ADUser
             $hash = @{
              Name = "$($user.GivenName) $($user.LastName)";
              Displayname = "$($user.GivenName) $($user.LastName)";
              Path = $ou;
              Surname = $($user.LastName);
              GivenName = $($user.GivenName);
              Samaccountname = $($accountName);
              UserPrincipalName = "$($accountName)@pheo.org";
              StreetAddress = $($user.StreetAddress);
              City = $($user.City);
              State = $($user.State);
              PostalCode = $($user.PostCode);
              Country = $($user.Country);
              OfficePhone = $($user.Phone);
              AccountPassword = $password;
              Enabled = $False;
              ChangePasswordAtLogon = $False;
             }
             #$hash

             $userCheck = (Get-ADUser -LDAPFilter "(SAMaccountname=$($accountname))" -ErrorAction SilentlyContinue) 
             Write-Verbose "$([string]::IsNullorEmpty($userCheck))"
             if ([string]::IsNullOrEmpty($userCheck)){
                New-ADUser @hash -PassThru           

             } else { Write-Output "User $accountName already exists in the directory"}

         }
     }
     End
     {
     }
 } 
 <#
 foreach ($user in $users) {

$password = $user.Password | ConvertTo-SecureString -AsPlainText -Force


 New-ADUser @hash -PassThru -Verbose
}
    #>

 <#
 .Synopsis
    Short description
 .DESCRIPTION
    Long description
 .EXAMPLE
    Example of how to use this cmdlet
 .EXAMPLE
    Another example of how to use this cmdlet
 #>
 function New-LabMailbox {
     [CmdletBinding()]
     [Alias()]
     [OutputType([int])]
     Param
     (
         # Param1 help description
         [Parameter(Mandatory=$true,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
         $Param1,
 
         # Param2 help description
         [int]
         $Param2
     )
 
     Begin
     {
     }
     Process
     {
     }
     End
     {
     }
 }