

$Group  = "GroupName@domain"
#Group that you want to retrive the members for

$RawGoogleGroupInfo = gam info group $Group


# RawGoogleGroupInfo has a ton of extra lines so you want to filter a 
# starting index of where the word Members: is plus one on the index. 
 
$StartIndex = $RawGoogleGroupInfo.IndexOf('Members:') + 1



#sets Indexes to a list of values starting from the starting index we just set to 2 less then the count of the rawgooglegroupinfo. 
#Last index of the rawgooglegroupinfo holds a string telling you the total members. 
$Indexes = $StartIndex..($RawGoogleGroupInfo.Count-2)


# Each line of the members section will be formated as " member: miriamalbor@riverbank.k12.ca.us (user)"
# So if you split on space you get [0] = '' [1]= member: and finally the email for [2]

$GroupMembers = $RawGoogleGroupInfo|Select-Object -index $Indexes|ForEach-Object {  ($_).split(' ')[2] }

#Finally in $GroupMembers we have a clean list of all the members of the group ( Note Owners and Users will be in this list )