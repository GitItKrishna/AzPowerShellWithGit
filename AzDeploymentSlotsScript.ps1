Connect-AzAccount
$resourceGroupName="DemoResourceGroupNew"
$AppServicePlanName="DemoAppServicePlanNew"
$webAppName="DemoWebApp5999"

Set-AzAppServicePlan -ResourceGroupName $resourceGroupName -Name $AppServicePlanName -Tier Standard

New-AzWebAppSlot -ResourceGroupName $resourceGroupName -Name $webAppName -Slot "staging"

$gitRepoUrl="https://github.com/GitItKrishna/AzPowerShellWithGit"

$PropertiesObject = @{
    repoUrl = $gitRepoUrl
    branch = "main"
    isManualIntegration = "true"
}

Set-AzResource -PropertyObject $PropertiesObject -ResourceGroupName $resourceGroupName `
-ResourceType Microsoft.Web/sites/slots/sourcecontrols `
-ResourceName $webAppName/staging/web  -ApiVersion 2018-02-01 -Force