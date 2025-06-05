BeforeAll {
    # Import the expected configuration
    $config = Get-Content .\config.json | ConvertFrom-Json
    $rg = Get-AzResourceGroup -Name ("rg-{0}-{1}-{2}" -f $config.AppServiceName, $config.Environment, $config.Number)
}
Describe "Azure Resource Group" {
    It "resource group should exist" {
        $rg | Should -Not -BeNullOrEmpty
    }
    It "resource group should be in correct location" {
        $rg.Location | Should -Be $config.Location
    }
}