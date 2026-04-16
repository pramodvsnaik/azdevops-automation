
Get-Content .env | foreach {
    $name, $value = $_.split('=')
    Set-Content env:\$name $value
}

az login --service-principal -u $env:AZURE_APP_ID -p $env:AZURE_SECRET -t $env:AZURE_TENANT_ID

$accessToken=az account get-access-token --resource $env:AZURE_APP_ID --query "accessToken" -o tsv

Write-Debug "Access Token: $accessToken"
Set-Content env:"ACCESS_TOKEN" $accessToken

az devops configure --defaults organization=$($configData.organization) project=$($configData.project)
Write-Debug "Organization: $($configData.organization),$($configData.project)"
    

function API-Call {

$apiVersion = "7.1-preview.1"
$uri = "https://dev.azure.com/$env:ORG_NAME/_apis/projects?api-version=7.2" 
$headers = @{
    Accept = "application/json"
    Authorization = "Bearer $accessToken"
}
Invoke-RestMethod -Uri $uri -Headers $headers -Method Get | ConvertTo-Json
#az rest --method get --url $uri --headers "Authorization=Bearer $accessToken" --headers "Accept=application/json"

}

#az devops team list --org https://dev.azure.com/$env:ORG_NAME --project azuredevops-automate