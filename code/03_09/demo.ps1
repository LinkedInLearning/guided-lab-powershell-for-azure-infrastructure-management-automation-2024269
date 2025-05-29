# Create multiple resources using a standard naming contention

# Get the password from key vault and create a PSCredential
$password = (Get-AzKeyVaultSecret -VaultName kv-linkedinpwsh-prod-001 -Name 'SQLServer-SvrAdmin').SecretValue 
$svrCred = [PsCredential]::New('SvrAdmin', $password)

# Set up some variables
$Location = "UKSouth"
$ResourceGroupName = "rg-linkedinpwsh-prod-001"
$appServiceName = 'linkedinpwsh'
$env = 'prod'
$num = '001'
$resourceName = ('{0}-{1}-{2}' -f $appServiceName, $env, $num)

#VM details
$VMSize = "Standard_B2s"
$publisherName = 'MicrosoftSQLServer'
$offer = 'sql2025-ws2025'
$sku = 'entdev-gen2' 
$version = 'latest'

# Networking details
$SubnetAddressPrefix = "10.0.0.0/24"
$vNetAddressPrefix = "10.0.0.0/16"

$subnetParams = @{
    Name          = ('snet-{0}' -f $resourceName)
    AddressPrefix = $SubnetAddressPrefix
}
$subnet = New-AzVirtualNetworkSubnetConfig @subnetParams

$vnetParams = @{
    Name              = ('vnet-{0}' -f $resourceName)
    ResourceGroupName = $ResourceGroupName
    Location          = $Location
    AddressPrefix     = $VnetAddressPrefix
    Subnet            = $subnet
}
$vnet = New-AzVirtualNetwork @vnetParams 

$nicParams = @{
    Name              = ('nic-{0}' -f $resourceName)
    ResourceGroupName = $ResourceGroupName
    Location          = $Location
    SubnetId          = $vnet.Subnets[0].Id
}
$nic = New-AzNetworkInterface @nicParams

$vmConfig = @{
    VMName = ('vm-{0}' -f $resourceName)
    VMSize = $VMSize
}
$VirtualMachine = New-AzVMConfig @vmConfig

$os = @{
    VM               = $VirtualMachine
    Windows          = $true
    ComputerName     = ('vm-{0}' -f $resourceName).Substring(0,15).TrimEnd('-')
    Credential       = $svrCred
    ProvisionVMAgent = $true
    EnableAutoUpdate = $true
}
$VirtualMachine = Set-AzVMOperatingSystem @os

$sourceImage = @{
    VM            = $VirtualMachine
    PublisherName = $publisherName
    Offer         = $offer
    Skus          = $sku
    Version       = $version
}
$VirtualMachine = Set-AzVMSourceImage @sourceImage

$vmnic = @{
    VM = $VirtualMachine
    Id = $NIC.Id
}
$VirtualMachine = Add-AzVMNetworkInterface @vmnic

$vmParams = @{
    ResourceGroupName = $ResourceGroupName
    Location          = $Location  
    VM                = $VirtualMachine
}
New-AzVM @vmParams

