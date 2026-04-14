param (
    $RootPath
)

if (-not (Get-Module -ListAvailable -Name powershell-yaml)) {
    Install-Module powershell-yaml -Scope CurrentUser -Force
}

Import-Module powershell-yaml

write-host "Root Path: $RootPath"
$CONFIG_PATH = "$RootPath/configs/userstoinvite.yaml"
$DebugPreference = "SilentlyContinue"

function AddUsersToAzureDevOps {
    Write-Host "Adding users to Azure DevOps organization..."
    $configData = Get-Content -Path $CONFIG_PATH | ConvertFrom-Yaml

    az devops configure --defaults organization=$($configData.organization)
    Write-Host "Organization: $($configData.organization)"
    
    
    foreach ($user in $configData.users) {
        Write-Host "Inviting user: $($user.email) with access level: $($user.access_level) to project: $($user.project)"
        Write-Debug "checking if user $($user.email) already exists in organization $($configData.organization)"
        
        az devops user add --email-id $user.email --organization $configData.organization --license-type stakeholder
        az devops security group list .\.env
        az devops security group membership add --group-id "a68bcd4b-749a-4bc2-a457-23f18fe61904" --member-id $user.email
    }

}


AddUsersToAzureDevOps