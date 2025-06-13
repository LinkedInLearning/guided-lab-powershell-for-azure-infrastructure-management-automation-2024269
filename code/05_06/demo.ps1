Set-Location .\code\05_06

# Look for spreadsheet files in the current directory
Get-ChildItem *.xlsx

# Import the spreadsheet
$newHires = Import-Excel -Path .\NewEmployees.xlsx -WorksheetName 'NewHires'

# Process the new hires
$newHires.foreach{
    Write-Output ('New hire: {0} {1} - {2}' -f $_.FirstName, $_.LastName, $_.StartDate)
}