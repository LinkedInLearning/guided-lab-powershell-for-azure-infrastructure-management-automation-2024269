Set-Location -Path .\code\05_02

# Get data about processes on the system
Get-Process | 
Select-Object Name, WorkingSet, PagedMemorySize, PrivateMemorySize, VirtualMemorySize, TotalProcessorTime, Handles, Path, Company, Description, Product

# Export the data to Excel
$processes = Get-Process | 
Select-Object Name, WorkingSet, PagedMemorySize, PrivateMemorySize, VirtualMemorySize, TotalProcessorTime, Handles, Path, Company, Description, Product

$processes | Export-Excel -Path "SystemProcesses.xlsx" -AutoSize

# Open the Excel file
Start-Process "SystemProcesses.xlsx"