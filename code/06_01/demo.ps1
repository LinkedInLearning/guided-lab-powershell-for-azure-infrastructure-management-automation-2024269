Set-Location .\code\06_01

# Add a helper function to convert column letters to numbers
# Convert column letter to number
function ConvertTo-ExcelColumnNumber {
    param([string]$columnLetter)
    
    $columnNumber = 0
    foreach ($char in $columnLetter.ToCharArray()) {
        $columnNumber = $columnNumber * 26 + ([int][char]$char - 64)
    }
    return $columnNumber
}

# Look for spreadsheet files in the current directory
Get-ChildItem *.xlsx

# Find the address of the Resource table
$e = Open-ExcelPackage -Path .\ProjectTemplate.xlsx
$address = $e.Workbook.Worksheets['ProjectTemplate'].Tables['Resources'].Address
$startCell = $address.Address.split(':')[0]
$column = [regex]::Match($startCell, "[A-Za-z]+").Value
$row = [regex]::Match($startCell, "\d+").Value
$column = ConvertTo-ExcelColumnNumber -columnLetter $column

# Import the spreadsheet
$importParams = @{
    Path           = '.\ProjectTemplate.xlsx'
    WorksheetName  = 'ProjectTemplate'
    StartRow       = $row
    StartColumn    = $column
}
$data = Import-Excel @importParams

# Also find the address of the Info table - this will become our tags
$e = Open-ExcelPackage -Path .\ProjectTemplate.xlsx
$address = $e.Workbook.Worksheets['ProjectTemplate'].Tables['Info'].Address
$startCell = $address.Address.split(':')[0]
$endCell = $address.Address.split(':')[1]
$startColumn = ConvertTo-ExcelColumnNumber -columnLetter ([regex]::Match($startCell, "[A-Za-z]+").Value)
$startRow = [regex]::Match($startCell, "\d+").Value
$endColumn = ConvertTo-ExcelColumnNumber -columnLetter ([regex]::Match($endcell, "[A-Za-z]+").Value)
$endRow = [regex]::Match($endcell, "\d+").Value

# Import the spreadsheet
$importParams = @{
    Path           = '.\ProjectTemplate.xlsx'
    WorksheetName  = 'ProjectTemplate'
    StartRow       = $startRow
    EndRow         = $endRow
    StartColumn    = $startColumn
    EndColumn      = $endColumn
}
$tags = Import-Excel @importParams
