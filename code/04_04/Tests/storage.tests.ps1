BeforeAll {
    # Import the expected configuration
    $config = Get-Content .\config.json | ConvertFrom-Json
    $rgName = ("rg-{0}-{1}-{2}" -f $config.AppServiceName, $config.Environment, $config.Number)
    $str = Get-AzStorageAccount -ResourceGroupName $rgName -Name ('st{0}{1}' -f $config.AppServiceName, $config.Number).ToLower()
}
Describe "Azure Storage Account" {
    It "storage account should exist" {
        $str.StorageAccountName | Should -Not -BeNullOrEmpty
    }
    It "storage account should be in correct location" {
        $str.PrimaryLocation | Should -Be $config.Location
    }
    It "storage account should be the right type" {
        $str.Sku.Name | Should -Be $config.StorageSku
    }
}