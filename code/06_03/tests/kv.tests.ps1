param (
    [Parameter(Mandatory)]
    [object] $data,
    
    [Parameter(Mandatory)]
    [string]$rgName
)

Describe "Azure Key Vault: <_.Name>" -ForEach $data {
    BeforeAll {
        $kv = Get-AzKeyVault -ResourceGroupName $rgName -Name $_.Name
        if($_.Properties) {
            $properties = $_.Properties.split(';').foreach{
                [PSCustomObject]@{
                    Key = $_.Split('=')[0]
                    Value = $_.Split('=')[1]
                }
            }
        }        
    }

    It "key vault should exist" {
        $kv.GetType() | Should -Not -BeNullOrEmpty
    }
    It "key vault should be in correct location" {
        $kv.Location | Should -Be $_.Location
    }
}


