$User = (Gam info user user@domain)

[datetime]$LastLogin = ($user|Select-String -Pattern "Last login time:").Tostring().Split(' ')[3]
$OU = ($user|Select-String -Pattern "Google Org Unit Path:").Tostring().Split(':').TrimStart(' ')[1]
$Suspended = ($user|Select-String -Pattern "Account Suspended:").Tostring().Split(':').TrimStart(' ')[1]


#User: user@domain
#First Name: UserFirstname
#Last Name: UserLastName
#Is a Super Admin: False
#Is Delegated Admin: False
#2-step enrolled: True
#2-step enforced: False
#Has Agreed to Terms: True
#IP Whitelisted: False
#Account Suspended: False
#Is Archived: False
#Must Change Password: False
#Google Unique ID: XXXXXXXXXXXXXXXXXXXXX
#Customer ID: XXXXXXXXXXX
#Mailbox is setup: True
#Included in GAL: True
#Creation Time: 2016-08-22T22:58:48.000Z
#Last login time: 2020-06-12T15:52:40.000Z
#Google Org Unit Path: /OU/SubOU
#Gender
# type: xXX

#Other Emails:
# address: user@domain
# address: user@domain.test-google-a.com
# 

#Email Aliases:
#  user@domain
#Non-Editable Aliases:
#  user@domain.test-google-a.com
#  
#Groups: (3)
#   GoogleGroup <GoogleGroup@domain>
#   
#Licenses: