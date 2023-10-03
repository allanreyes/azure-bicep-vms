Get-AzContext 

$resourceGroupName = "rg-azvmtest2"


$params = @{
    vmName   = "vmallanreyes"
    vnetName = "vnet-allanreyes"
    nicName  = "vmallanreyes-nic"
    pipName  = "vmallanreyes-ip"
    nsgName  = "vmallanreyes-nsg"
}


New-AzResourceGroup -Name $resourceGroupName -Location "canadaeast" -Force | Out-Null

New-AzResourceGroupDeployment -Name "deploy" `
    -ResourceGroupName $resourceGroupName `
    -TemplateFile .\main.bicep `
    -TemplateParameterObject $params `
    -Verbose


#Write-Host $deployment.Outputs["testOutput"].Value

# New-AzSubscriptionDeployment -Name "deploy" `
#     -Location $location `
#     -TemplateFile .\main.bicep `
#     -TemplateParameterFile $templateParametersFile `
#     -Verbose

