Set-Location .\code\04_05

# Connect to Azure once here
Connect-AzAccount - tenant 'EnterTenantId'

# Let's create some extra resource groups to test with
2..9 | Foreach-Object {
    $location = "UKSouth"
    # pop one in the wrong location
    if($_ -eq 7) { $location = 'UKWest'}

    $rg = @{
        Name     = ('rg-linkedinpwsh-prod-00{0}' -f $_)
        Location = $location
    }
    New-AzResourceGroup @rg
}

# import the config
$config = Get-Content .\config.json | ConvertFrom-Json

# get the resource groups
$rgs = Get-AzResourceGroup | Where-Object ResourceGroupName -like 'rg-linkedinpwsh-prod*'

# Call a folder of Pester tests with the data passed in
$container = New-PesterContainer -Path .\Tests -Data @{ config = $config; rgs = $rgs }
Invoke-Pester -Container $container -Output Detailed
