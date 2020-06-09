

$ErrorActionPreference ='SilentlyContinue'

$Today = Get-date

$DaysSinceSync=999999

############## 
# Setting the $ErrorActionPreference to SilentlyContinue will block errors
# from showing you can still access the $Error Variable 
# $Error[0] Should contain "Got 1 CrOS Devices..."
# That will give you a way to test and break loops if your getting errors.. 
#Also remmber you can clear the $Error variable with $Error.Clear()

$SSN = 'LI9TFQIN19298354'

########################################
# $DeviceID[0]= deviceId
# $DeviceID[1] = The Device Guid
#######################################

$DeviceID = (gam print cros query $SSN)[1]
$TestError = $Error[0].ToString().split(' ')[1]
$Error.Clear()

if($TestError -ne '0'){

    $Report = gam info cros $DeviceID
}

## Get the time betweeen Chromebook last synced with google is days. 

[datetime]$Date = ($Report|Select-String -Pattern "lastSync:").ToString().Split(' ')[3]
$DaysSinceSync = (New-TimeSpan -Start $Date -End $Today).Days

if($DaysSinceSync -gt 30){
    ####
    # Do some code to flag the chromebook. 
    ####
}





#######################################
#Sample of $Report
#CrOS Device: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx (1 of 1)
             
#  orgUnitPath: /
#  annotatedUser: user@domain
#  lastSync: 2019-11-22T00:54:22.220Z
#  serialNumber: XXXXXXXXXXXXXXXXXX
#  status: ACTIVE
#  model: CTL chromebook NL7
#  firmwareVersion: Google_Coral.10068.86.0
#  platformVersion: 12499.66.0 (Official Build) stable-channel coral
#  osVersion: 78.0.3904.106
#  bootMode: Verified
#  macAddress: XXXXXXXXXXXX
#    systemRamTotal: 4013404160
#  lastEnrollmentTime: 2019-08-10T20:37:38.751Z
#  autoUpdateExpiration: 2024-06-01
#  tpmVersionInfo:   family: 322e3000
#   specLevel: 74
#   manufacturer: 43524f53
#   tpmModel: 1
#   firmwareVersion: 8b408db0844afba
#   vendorSpecific: 784347206654504D
#   tpmVulnerability: NOT IMPACTED
#  activeTimeRanges
#    date: 2019-11-15
#      activeTime: 510048
#     duration: 00:08:30
#      minutes: 8
#    date: 2019-11-19
#      activeTime: 750009
#      duration: 00:12:30
#      minutes: 12
#  recentUsers
#    type: USER_TYPE_MANAGED
#      email: jeramiahfridley-vazquez@riverbank.k12.ca.us
#    type: USER_TYPE_MANAGED
#      email: jessicaacosta@riverbank.k12.ca.us
#  cpuStatusReports
#    reportTime: 2019-11-25T16:02:03.043Z
#      cpuTemperatureInfo
#        Core 2: 26
#        Physical id 0: 26
#        Core 0: 24
#        iwlwifi: 22
#      cpuUtilizationPercentageInfo: 82
#    reportTime: 2019-11-25T18:40:25.809Z
#      cpuTemperatureInfo
#        Core 2: 49
#        Physical id 0: 49
#        Core 0: 48
#        iwlwifi: 27
#      cpuUtilizationPercentageInfo: 82
#  diskVolumeReports
#    volumeInfo
#      volumeId: /home/chronos/u-6bcea4b151143694f619591dd75bbcfb04fd379a/MyFiles
#        storageFree: 800051200
#        storageTotal: 26254479360
#      volumeId: /run/arc/sdcard/write/emulated/0
#        storageFree: 800051200
#        storageTotal: 26254479360
#      volumeId: /media/archive
#        storageFree: 2006700032
#        storageTotal: 2006700032
#      volumeId: /media/fuse/drivefs-eb297c831aba78fabe71e352144546cd
#        storageFree: 1152921504058236928
#        storageTotal: 1152921504606846976
#      volumeId: /usr/share/oem
#        storageFree: 11681792
#        storageTotal: 12042240
#     volumeId: /media/removable
#        storageFree: 2006700032
#        storageTotal: 2006700032
#      volumeId: /media/fuse/drivefs-eb297c831aba78fabe71e352144546cd
#        storageFree: 1152921504058236928
#        storageTotal: 1152921504606846976
#  systemRamFreeReports
#    reportTime: 2019-11-25T16:02:03.043Z
#      systemRamFreeInfo: 2788597760
#    reportTime: 2019-11-25T18:40:25.809Z
#      systemRamFreeInfo: 2775715840
