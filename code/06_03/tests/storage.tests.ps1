param (
    [Parameter(Mandatory)]
    [object] $data,
    
    [Parameter(Mandatory)]
    [string]$rgName
)

Describe "Azure Storage Account: <_.Name>" -ForEach $data {
    BeforeAll {
        $str = Get-AzStorageAccount -ResourceGroupName $rgName -Name $_.Name
        $str | ogv
        if($_.Properties) {
            $properties = $_.Properties.split(';').foreach{
                [PSCustomObject]@{
                    Key = $_.Split('=')[0]
                    Value = $_.Split('=')[1]
                }
            }
        }        
    }

    It "storage account should exist" {
        $str | Should -Not -BeNullOrEmpty
    }
    It "storage account should be in correct location" {
        $str.PrimaryLocation | Should -Be $_.Location
    }
    It "storage account should be the right type" {
        $str.Sku.Name | Should -Be ($Properties | Where-Object Key -eq 'SkuName').Value
    }
}


