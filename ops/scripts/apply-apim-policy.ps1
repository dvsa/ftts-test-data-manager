################################################################################################################################################################################
### Apply APIM XML Policy to API
###
### Script based on provided policy in the xml file can add it on different scope. If parameter 'OperationName' is not set - it will add it on API scope. 
### When parameter 'operationName is set then script will add policy on operation scope.
###
### Usage:
### apply-apim-policy.ps1 -serviceName $(apimServiceName) -resourceGroup $(apimResourceGroup) -apiName $(apiName) -policyFile $(policyFile) -operationName $(operationName)
################################################################################################################################################################################

param (
    [Parameter(Position = 0, Mandatory = $true)]
    [string]
    $serviceName,
    [Parameter(Position = 1, Mandatory = $true)]
    [string]
    $resourceGroup,
    [Parameter(Position = 2, Mandatory = $true)]
    [string]
    $apiName,
    [Parameter(Position = 3, Mandatory = $true)]
    [string]
    $policyFile,
    [Parameter(Position = 4, Mandatory = $false)]
    [string]
    $operationName
)

$apimContext = New-AzApiManagementContext -ResourceGroupName $resourceGroup -ServiceName $serviceName
$policy = Get-Content -Path $policyFile -Raw

if ( $operationName ) {
    Set-AzApiManagementPolicy -Context $apimContext -ApiId $apiName -OperationId $operationName -Policy $policy -Format "application/vnd.ms-azure-apim.policy.raw+xml"
} else {
    Set-AzApiManagementPolicy -Context $apimContext -ApiId $apiName -Policy $policy -Format "application/vnd.ms-azure-apim.policy.raw+xml"
}
