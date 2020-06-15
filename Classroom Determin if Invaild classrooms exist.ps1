############# Get Group Members #########

$Group  = "classroom_teachers@riverbank.k12.ca.us"

$RawGoogleGroupInfo = gam info group $Group
 
$StartIndex = $RawGoogleGroupInfo.IndexOf('Members:') + 1

$Indexes = $StartIndex..($RawGoogleGroupInfo.Count-2)

$GroupMembers = $RawGoogleGroupInfo|Select-Object -index $Indexes|ForEach-Object {  ($_).split(' ')[2] }
################## End of Getting Group Members ###################


$TeacherObject =@()
foreach($TCH in $GroupMembers){
   # Gets the user info for each of the group members. 
   $User = (gam info user $TCH)
   #Test to see if User is a record
   if($User){
           #Selects the ID from the report
        $ID= ($user|Select-String -Pattern 'Google Unique ID:').ToString().Split(':').TrimStart(' ')[1]

   }
   #Adds the ID and email to a object arrary.
   $TeacherObject += New-Object psobject -Property @{
       "Id"=$ID
       "Email" = $TCH
   }

}
#Gets all the google classrooms with state active
$courses = (gam print courses state active)
#Creates a file to add to use to covert the text strings into a csv.
new-item -ItemType File -Path C:\scripts\data\ClassRawData.csv -Force
#adds each line of ',' text to the csv file.
foreach($course in $courses){
    Add-Content -Path C:\scripts\data\ClassRawData.csv -Value $course

}
#brings in the clean csv file 
$Classrooms = import-csv C:\scripts\data\Somejunk.csv|select Id,Name,ownerId

#Blank Object to add our bad classrooms objects to
$BadClassroom = @()
foreach($Class in $Classrooms){
    #Gets the Teacher that matches the class
    $TeacherTest = $TeacherObject|Where-Object -Property id -eq $Class.ownerId
    #if No match log out the classroom
    if(!$TeacherTest){

        $BadClassroom += new-object psobject -Property @{ 
            "ClassID" = $Class.ID
            "ClassName" = $Class.name
            "OwerID" = $Class.ownerId
            }
    }

}
#export the final report to a csv... 
$badClassroom|export-csv C:\scripts\data\BadClassReport.csv -NoTypeInformation

