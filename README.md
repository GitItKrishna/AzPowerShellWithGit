**A repo to create a webapp using powershell commands and github integration**

Please refer to the below screenshot for the powershell commands to create a web app.

![img.png](MyWebApp/Images/img.png)

## Steps to Create a Webapp using powershell commands and github integration
1. Create a new repository in github
2. Clone the repository to your local machine
3. Create a new folder in the cloned repository
4. Test your local sample project by running it and see if it works
5. Create a new powershell script file in the root of the repository
6. Add the following code to the powershell script file
```powershell
Connect-AzAccount
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
```
7. the details of the above powershell script is as shown below.
```aiignore
1. Connect to Azure Account:  
Connect-AzAccount
This command prompts you to log in to your Azure account.  

2. Set Variables:  
$location="South Central US"
$resourceGroupName="DemoResourceGroupNew"
These variables store the location and resource group name for the Azure resources.  

3. Create Resource Group:  
New-AzResourceGroup -Name $resourceGroupName -Location $location
This command creates a new resource group in the specified location.  

4. Create App Service Plan:  
$AppServicePlanName="DemoAppServicePlanNew"
New-AzAppServicePlan -ResourceGroupName $resourceGroupName -Name $AppServicePlanName -Location $location -Tier Basic
This command creates a new App Service Plan within the resource group.  

5. Create Web App:  
$webAppName="DemoWebApp5999"
New-AzWebApp -ResourceGroupName $resourceGroupName -Name $webAppName -Location $location -AppServicePlan $AppServicePlanName
This command creates a new Web App within the App Service Plan.  

6. Set GitHub Repository URL:  
$gitRepoUrl="https://github.com/GitItKrishna/AzPowerShellWithGit"
This variable stores the URL of the GitHub repository to be integrated with the Web App.  
Configure Source Control:  
$PropertiesObject = @{
    repoUrl = $gitRepoUrl
    branch = "main"
    isManualIntegration = "true"
}

Set-AzResource -PropertyObject $PropertiesObject -ResourceGroupName $resourceGroupName `
-ResourceType Microsoft.Web/sites/sourcecontrols `
-ResourceName $webAppName/web  -ApiVersion 2018-02-01 -Force

This block of code sets the source control configuration for the Web App, linking it to the specified GitHub repository and branch. The Set-AzResource command applies these settings to the Web App.
```
8. Run the powershell script file in the powershell terminal
You can see the output as shown below. After you are logged in successfully, you are asked to choose the subscription as i have multiple subscriptions on my azure account.
![img_1.png](MyWebApp/Images/img_1.png)
9. I have selected the subscription as 2  and you can see the resources are created in a sequential order.

![img_2.png](MyWebApp/Images/img_2.png)
![img_3.png](MyWebApp/Images/img_3.png)
![img_7.png](MyWebApp/Images/img_7.png)
10. After running the above script, switch to azure portal and click on All Resources to see all the resources created .
11. You can observe resource group, app service plan and web app created as shown below.
![img_8.png](MyWebApp/Images/img_8.png)
12. Also, select the web app and click on deployment center to see the github integration.

![img_4.png](MyWebApp/Images/img_4.png)
13. Select the webapp and select the default domain and copy the url.

![img_5.png](MyWebApp/Images/img_5.png)
14. Paste the url in the browser and you can see the webapp created.

![img_6.png](MyWebApp/Images/img_6.png)

**Deployment Slots using Azure PowerShell:-**

The deployment slot functionality in App Service is a powerful tool that enables you to preview, manage, test, and deploy your different development environments.
```aiignore
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
```

```
Here is a step-by-step explanation:  

1. Connect to Azure Account:  
Connect-AzAccount

This command prompts you to log in to your Azure account.  

2. Set Variables:  
$resourceGroupName="DemoResourceGroupNew"
$AppServicePlanName="DemoAppServicePlanNew"
$webAppName="DemoWebApp5999"

These variables store the resource group name, App Service Plan name, and Web App name for the Azure resources.  

3. Upgrade App Service Plan:  
Set-AzAppServicePlan -ResourceGroupName $resourceGroupName -Name $AppServicePlanName -Tier Standard

This command upgrades the App Service Plan to the Standard tier, which is required for deployment slots.  

4. Create Deployment Slot:  
New-AzWebAppSlot -ResourceGroupName $resourceGroupName -Name $webAppName -Slot "staging"

This command creates a new deployment slot named "staging" for the specified Web App.  

5. Set GitHub Repository URL:  
$gitRepoUrl="https://github.com/GitItKrishna/AzPowerShellWithGit"

This variable stores the URL of the GitHub repository to be integrated with the deployment slot.  

6. Configure Source Control for Deployment Slot:  
$PropertiesObject = @{
    repoUrl = $gitRepoUrl
    branch = "main"
    isManualIntegration = "true"
}

Set-AzResource -PropertyObject $PropertiesObject -ResourceGroupName $resourceGroupName `
-ResourceType Microsoft.Web/sites/slots/sourcecontrols `
-ResourceName $webAppName/staging/web  -ApiVersion 2018-02-01 -Force
This block of code sets the source control configuration for the deployment slot, linking it to the specified GitHub repository and branch. The Set-AzResource command applies these settings to the deployment slot.
```
After running the above script, you can see the sequence of events in the terminal console.

![img_9.png](MyWebApp/Images/img_9.png)
![img_10.png](MyWebApp/Images/img_10.png)

Now switch to azure portal and click on All Resources to see all the resources created .
Select the web app and click on deployment slots to see the staging slot created.(Screenshot below)

![img_11.png](MyWebApp/Images/img_11.png)

You can see the staging slot created as shown.

Select the staging slot and select the url next to default domain and open the new tab in the browser window.

![img_12.png](MyWebApp/Images/img_12.png)

You can see the staging slot website.(screenshot below)
![img_13.png](MyWebApp/Images/img_13.png)

**Switching the Deployment Slot to Production:-**
```aiignore
Switch-AzWebAppSlot -ResourceGroupName $resourceGroupName -Name $webAppName -SourceSlotName "staging" -DestinationSlotName "production"
```
After running the above script, browse the same url and you can observe the production web changed to staging and vice versa.

![img_14.png](MyWebApp/Images/img_14.png)

