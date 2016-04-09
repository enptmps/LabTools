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
 function Initialize-LabUser
 {
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

         [switch]$International

         

     )
 
     Begin
     {
          $seed = 'enpointe'
          Write-Verbose "Seed is hardcoded to $seed in this verstion of Initialize-LabUser"
     }
     Process
     {
         if (!($International)){
         Write-Verbose "Collecting user data for $count users to be located in the USA"
         $randomusers = Invoke-RestMethod -Uri "http://api.randomuser.me/?inc=name,location,phone,cell&results=$count&seed=$seed&nat=us&format=csv"
         }

         else {
         Write-Verbose "Collecting user data for $count users to be located internationally"
         $randomusers = Invoke-RestMethod -Uri "http://api.randomuser.me/?inc=name,location,phone,cell&results=$count&seed=$seed&nat=us,gb,fr,au,nz,dk&format=csv"
         }
     }
     End
     {
          return $randomusers
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
 function New-LabUser
 {
     [CmdletBinding()]
     [Alias()]
     [OutputType([int])]
     Param
     (
         # Param1 help description
         [Parameter(Mandatory=$true,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
         $UserList,
 
         # Param2 help description
         [string]$OU
     )
 
     Begin
     {
        if (!($OU)){
        $OU = (Get-ADDomain).UsersContainer
        }

     }
     Process
     {
        ForEach($user in $UserList){
            New-ADUser -Fir
     }
     End
     {
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
 function New-LabMailbox
 {
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