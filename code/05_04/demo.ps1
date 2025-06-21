Set-Location .\code\05_04

# Connect to Azure
Connect-AzAccount -Tenant f98042ad-9bbc-499d-adb4-17193696b9a3

# Set a variable
$excelParams = @{
    Path       = 'AzureResources.xlsx' 
    AutoSize   = $true
    TableStyle = 'Medium4'
}

# Export resources from a resource group
Get-AzResource -ResourceGroup rg-linkedinpwsh-prod-001 |
Select-Object ResourceName, Location, ResourceGroupName, ResourceType | 
Export-Excel @excelParams -WorksheetName Resources -TableName Resources

# Let's add a second worksheet for resource groups
Get-AzResourceGroup | Where-Object ResourceGroupName -like 'rg-linkedinpwsh-prod*' |
Select-Object ResourceGroupName, Location, Tags | 
Export-Excel @excelParams -WorksheetName ResourceGroups -TableName ResourceGroups

