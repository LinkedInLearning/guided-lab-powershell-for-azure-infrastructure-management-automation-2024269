# Create a Resource Group
$rg = @{
    Name     = "rg-linkedinpwsh-prod-001"
    Location = "ukSouth"
}
New-AzResourceGroup @rg

# Get a Resource Group
Get-AzResourceGroup -Name rg-linkedinpwsh-prod-001