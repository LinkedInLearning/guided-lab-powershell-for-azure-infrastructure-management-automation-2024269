# Review the help, there are a lot of parameters available
Get-Help New-AzStorageAccount

# Create a Storage Account
$storageAcc = @{
    ResourceGroupName = "rg-linkedinpwsh-prod-001"
    Name              = "stlinkedinpwsh001"
    Location          = "UkSouth"
    SkuName           = "Standard_LRS"
}
New-AzStorageAccount @storageAcc


# Create a Storage Account
$storageAcc = @{
    ResourceGroupName = "rg-linkedinpwsh-prod-001"
    Name              = "stlinkedinpwsh001"
    Location          = "UkSouth"
    SkuName           = "Standard_LRS"
}
New-AzStorageAccount @storageAcc