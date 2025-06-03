# Change directory to the specific demo folder
Set-Location .\code\04_02\

# dot source the function
. .\Test-IsEven.ps1

# Test the function
Test-IsEven -Number 2 # would expect true
Test-IsEven -Number 3 # would expect false

# Execute the pester tests
Invoke-Pester -Path "./Test-IsEven.Tests.ps1"

# Execute with more detailed output
Invoke-Pester -Path "./Test-IsEven.Tests.ps1" -Output Detailed
