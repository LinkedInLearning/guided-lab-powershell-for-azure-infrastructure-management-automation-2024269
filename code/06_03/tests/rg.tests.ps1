param (
    [Parameter(Mandatory)]
    [object] $data
)
Describe "Azure Resource Group: <_.ResourceGroupName>" -ForEach $data {
    BeforeAll {
        $rg = Get-AzResourceGroup -Name $_.Name
    }        
    It "resource group should exist" {
        $rg | Should -Not -BeNullOrEmpty
    }
    It "resource group provisioning state should be succeeded" {
        $rg.ProvisioningState | Should -Be 'Succeeded'
    }
    It "resource group should be in correct location" {
        $rg.Location | Should -Be $_.Location
    }

}
