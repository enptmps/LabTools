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
         $Count = '1',

         [switch]$International
     )
 
     Begin
     {
          $seed = 'enpointe'
          Write-Verbose "Seed is hardcoded to $seed"
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
