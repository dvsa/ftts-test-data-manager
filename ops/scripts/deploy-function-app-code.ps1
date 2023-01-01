################################################################################################################################################################
### Upload function package & set WEBSITE_RUN_FROM_PACKAGE value to the URI of the package on function backing storage
###
### Usage:
### deploy-function-app-code.ps1 -functionName ($functionName) -functionStorageName $(functionStorageName) -resourceGroup $(resourceGroup)
################################################################################################################################################################

param (
    [Parameter(Position = 0, Mandatory = $true)]
    [string]
    $functionName,
    [Parameter(Position = 1, Mandatory = $true)]
    [string]
    $functionStorageName,
    [Parameter(Position = 2, Mandatory = $true)]
    [string]
    $resourceGroup
)

function Publish-Package {
    $publishPackage = az storage blob upload --account-name $($functionStorageName) --container-name $($packageContainer) --file $($packageName) --name $($packageName)
}

$leaf = Split-Path -Path (Get-Location) -Leaf
$zip = $($leaf) + '*.zip'
$packageName = Get-Item  $zip | Select-Object Name -ExpandProperty Name
$packageContainer = 'azure-pipelines-deploy'
$blobUri = 'https://' + $($functionStorageName) + '.blob.core.windows.net/' + $($packageContainer) + '/' + $($packageName)

$containerExists = az storage container exists --account-name $($functionStorageName) --name $($packageContainer) -o tsv
$packageExists = az storage blob exists --account-name $($functionStorageName) --container-name $($packageContainer) --name $($packageName) -o tsv

if ($($containerExists) -eq $false) {
    Write-Output "Creating blob container"
    $createContainer = az storage container create --account-name $($functionStorageName) --name $($packageContainer)
    Write-Output "Publishing package"
    Publish-Package
} elseif ($($containerExists) -eq $true -And $($packageExists) -eq $false) {
    Write-Output "Publishing package"
    Publish-Package
} else {
    Write-Output "Package and container already exist"
}

Write-Output "Setting package URI"
$updateAppSettings = az functionapp config appsettings set --name $($functionName) --resource-group $($resourceGroup) --settings "WEBSITE_RUN_FROM_PACKAGE=$($blobUri)"
Write-Output "Restarting function"
$restart = az functionapp restart --name $($functionName) --resource-group $($resourceGroup)
