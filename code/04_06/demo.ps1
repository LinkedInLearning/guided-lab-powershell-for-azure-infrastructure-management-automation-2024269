Set-Location .\code\04_06

# Connect to Azure once here
Connect-AzAccount - tenant 'EnterTenantId'

# import the config
$config = Get-Content .\config.json | ConvertFrom-Json

# get the resource groups
$rgs = Get-AzResourceGroup | Where-Object ResourceGroupName -like 'rg-linkedinpwsh-prod*'

# Call a folder of Pester tests with the data passed in
$container = New-PesterContainer -Path .\Tests -Data @{ config = $config; rgs = $rgs }
Invoke-Pester -Container $container -Output Detailed
