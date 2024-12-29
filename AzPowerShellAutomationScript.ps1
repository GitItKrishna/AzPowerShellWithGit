Connect-AzAccount
#Get-AzLocation
$location="South Central US"    
$resourceGroupName="DemoResourceGroupNew"
New-AzResourceGroup -Name $resourceGroupName -Location $location

$AppServicePlanName="DemoAppServicePlanNew"
New-AzAppServicePlan -ResourceGroupName $resourceGroupName -Name $AppServicePlanName -Location $location -Tier Basic

$webAppName="DemoWebApp5999"
New-AzWebApp -ResourceGroupName $resourceGroupName -Name $webAppName -Location $location -AppServicePlan $AppServicePlanName

$gitRepoUrl="https://github.com/GitItKrishna/AzPowerShellWithGit"

$PropertiesObject = @{
    repoUrl = $gitRepoUrl
    branch = "main"
    isManualIntegration = "true"
}

Set-AzResource -PropertyObject $PropertiesObject -ResourceGroupName $resourceGroupName `
-ResourceType Microsoft.Web/sites/sourcecontrols `
-ResourceName $webAppName/web  -ApiVersion 2018-02-01 -Force