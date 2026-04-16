param (
    $NewRepoName,
    $NewRepoType,
    $RootPath
    )

# This script is responsible for creating variable groups in Azure DevOps.
write-host "This is a function template. Replace FunctionName with the actual name of the function and add your code here."

function Create-VariableGroup(
    $NewRepoName,
    $projectName,
    $orgName
) {
 try {
    
    az pipelines variable-group create `
    --name "VG_$NewRepoName" `
    --variables "Var1=Value1" "Var2=Value2" "Var3=Value3" `
    --org https://dev.azure.com/$env:ORG_NAME `
    --project azuredevops-automate
}
 catch {
    <#Do this if a terminating exception happens#>
 }
    
}

function List-VariableGroup(
) {
 try {


    az pipelines variable-group list --org https://dev.azure.com/$env:ORG_NAME `
    --project azuredevops-automate

}
 catch {
    <#Do this if a terminating exception happens#>
 }
    
}

List-VariableGroup