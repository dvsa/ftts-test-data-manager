################################################################################################################################################################
### Set ADO pipeline build / deploy retention lease
###
### Usage:
### build-retention.ps1
################################################################################################################################################################

$headers = @{ Authorization = "Bearer $($env:systemAccessToken)" };
$rawRequest = @{
    daysValid = 365 * 2;
    definitionId = $($env:systemDefinitionId);
    ownerId = "User: $($env:buildRequestedFor)";
    protectPipeline = $false;
    runId = $($env:buildBuildId)
};
$request = ConvertTo-Json @($rawRequest);
$uri = "$($env:systemCollectionUri)$($env:systemTeamProject)/_apis/build/retention/leases?api-version=6.0-preview.1";

Invoke-RestMethod -uri $uri -method POST -Headers $headers -ContentType "application/json" -Body $request;
