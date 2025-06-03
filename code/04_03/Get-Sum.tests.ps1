BeforeAll {
    # dot source the function
    . .\Get-Sum.ps1
}
Describe "Get-Sum" {
    Context "Testing Positive inputs" {

        It "returns 5 when adding 2 and 3" {
            Get-Sum -a 2 -b 3 | Should -Be 5
        }
        It "returns an integer" {
            $result = Get-Sum -a 1 -b 2
            $result.GetType().Name | Should -Be 'Int32'
        }
        It "returns a positive result for two positive numbers" {
            Get-Sum -a 4 -b 7 | Should -BeGreaterThan 0
        }
    }
    Context "Testing Negative inputs" {
        It "returns zero when summing -2 and 2" {
            Get-Sum -a -2 -b 2 | Should -Be 0
        }
        It "handles negative numbers correctly" {
            Get-Sum -a -5 -b 3 | Should -Be -2
        }
    }
    Context "Test error handling" {
        It "throws an error if a parameter is missing" {
            { Get-Sum -a 1 } | Should -Throw
        }
    }
}
