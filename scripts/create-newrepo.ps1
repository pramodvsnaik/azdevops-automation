
param (
    $NewRepoName,
    $NewRepoType,
    $RootPath
    )

write-host "This is a function template. Replace FunctionName with the actual name of the function and add your code here."
write-host "Creating new repository $NewRepoName of type $NewRepoType"
 
az repos create --name New_App --project azuredevops-automate --organization https://dev.azure.com/cosmotal 

New-Item -ItemType Directory -Path "temp/$NewRepoName" -Force | Out-Null 
Copy-Item -Path "$RootPath/Templates/$NewRepoType/*" -Destination "$RootPath/temp/$NewRepoName" -Recurse -Force

Set-Location "$RootPath/temp/$NewRepoName"

git init "$RootPath/temp/$NewRepoName"
git checkout -b main 
git add .
git commit -m "Initial commit for $NewRepoName"

git checkout -b dev
git add .
git commit -m "Initial commit for $NewRepoName"

git config --global user.email "admin@example.com"
git config --global user.name "Admin User"



git remote add origin "https://cosmotal@dev.azure.com/cosmotal/azuredevops-automate/_git/$NewRepoName"
git push -u origin main
git push -u origin dev

function Create-Repo(
    $NewRepoName,
    $projectName,
    $orgName
) {
 try {
    
    $URL="https://dev.azure.com/$orgName/$projectName/apis/git/repositories$NewRepoName"
    POST https://dev.azure.com/$orgName/$projectName/_apis/git/repositories?api-version=7.2-preview.2
    
}
 catch {
    <#Do this if a terminating exception happens#>
 }
    
}




