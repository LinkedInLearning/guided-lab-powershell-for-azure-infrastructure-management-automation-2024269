Set-Location -Path .\code\05_03

# Export the data to Excel
    $processes = Get-Process | 
    Select-Object Name, WorkingSet, PagedMemorySize, PrivateMemorySize, VirtualMemorySize, TotalProcessorTime, Handles, Path, Company, Description, Product

    $excelParams = @{
        Path = "SystemProcesses.xlsx"
        AutoSize = $true
        WorksheetName = "Processes"
        TableName = "ProcessData"
        TableStyle = "Medium5"
    }
    $processes | Export-Excel @excelParams

# Open the Excel file and apply conditional formatting
    $excel = Open-ExcelPackage -Path "SystemProcesses.xlsx"
    $worksheet = $excel.Workbook.Worksheets['Processes']

    $conditionalFormattingParams = @{
        WorkSheet = $worksheet
        Address = $worksheet.Dimension.Address
        RuleType = "Expression"
        ConditionValue = '=$B2>=LARGE($B:$B, 10)'
        BackgroundColor = "Orange"  
    }
    Add-ConditionalFormatting @conditionalFormattingParams

    Close-ExcelPackage $excel -Show