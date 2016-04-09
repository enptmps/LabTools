function Initialize-LabUser {
  $count = 1
  $seed = enpointe
  $global = false
  
  $randomusers = Invoke-RestMethod -Url 'http://api.randomuser.me/?inc=name,location,phone,cell&results=$count&seed=$seed&nat=us&format=csv'
}
