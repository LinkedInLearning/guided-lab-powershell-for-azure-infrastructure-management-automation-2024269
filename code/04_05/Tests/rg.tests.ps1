param (

    [Parameter(Mandatory)]
    [object] $config,

    [Parameter(Mandatory)]
    [Object] $rgs
)

    Describe "Azure Resource Group: <_.ResourceGroupName>" -ForEach $rgs {
    It "resource group provisioning state should be succeeded" {
        $_.ProvisioningState | Should -Be 'Succeeded'
    }
    It "resource group should be in correct location" {
        $_.Location | Should -Be $config.Location
    }
}