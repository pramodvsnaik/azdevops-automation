$RootPath=$PSScriptRoot

& "$RootPath/scripts/utility.ps1" 
#& "$RootPath/scripts/mgmt-users.ps1" $RootPath
& "$RootPath/scripts/mgmt-variablegroups.ps1" "MyNewRepo" "GitHub" $RootPath