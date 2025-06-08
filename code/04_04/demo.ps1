# Applying Pester to Azure Resource testing
Set-Location .\code\04_04\

# Connect to Azure once here
Connect-AzAccount -Tenant 'EnterTenantId'

# Call a folder of Pester tests
Invoke-Pester -Path .\Tests -Output Detailed