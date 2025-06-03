Describe "Test-IsEven" {
    It "returns $true for even numbers" {
        Test-IsEven -Number 4 | Should -Be $true
        Test-IsEven -Number 4 | Should -BeOfType [System.Boolean]
    }
    
    It "returns $false for odd numbers" {
        Test-IsEven -Number 3 | Should -Be $false
        Test-IsEven -Number 3 | Should -BeOfType [System.Boolean]
    }
}
