#region Connect using a Managed Service Identity
try {
    Write-Output "Connecting to Azure using Managed Service Identity..."
    $AzureConnection = (Connect-AzAccount -Identity).context
    # set and store context
    $AzureContext = Set-AzContext -SubscriptionName $AzureConnection.Subscription -DefaultProfile $AzureConnection
}
catch {
    Throw "Issue connecting with Managed Service Identity. Aborting." 
    exit
}
#endregion

#region download the Excel file from blob storage
# SAS token is stored as an encrypted variable1
$sas = Get-AutomationVariable -Name SASToken

# download the file
$fullUri = ('https://stlinkedindata001.blob.core.windows.net/project-templates/ProjectTemplate.xlsx?{0}' -f $sas)
$excelFile = ("{0}\test.xlsx" -f $env:TEMP )
Invoke-WebRequest -Uri $fullUri -OutFile $excelFile

#endregion

#region Code from 06-01 - Import the $resources and $tags

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

# Find the address of the Resource table
$e = Open-ExcelPackage -Path $excelFile
$address = $e.Workbook.Worksheets['ProjectTemplate'].Tables['Resources'].Address
$startCell = $address.Address.split(':')[0]
$column = [regex]::Match($startCell, "[A-Za-z]+").Value
$row = [regex]::Match($startCell, "\d+").Value
$column = ConvertTo-ExcelColumnNumber -columnLetter $column

# Import the spreadsheet
$importParams = @{
    Path           = $excelFile
    WorksheetName  = 'ProjectTemplate'
    StartRow       = $row
    StartColumn    = $column
}
$data = Import-Excel @importParams

# Also find the address of the Info table - this will become our tagsy

$e = Open-ExcelPackage -Path $excelFile
$address = $e.Workbook.Worksheets['ProjectTemplate'].Tables['Info'].Address
$startCell = $address.Address.split(':')[0]
$endCell = $address.Address.split(':')[1]
$startColumn = ConvertTo-ExcelColumnNumber -columnLetter ([regex]::Match($startCell, "[A-Za-z]+").Value)
$startRow = [regex]::Match($startCell, "\d+").Value
$endColumn = ConvertTo-ExcelColumnNumber -columnLetter ([regex]::Match($endcell, "[A-Za-z]+").Value)
$endRow = [regex]::Match($endcell, "\d+").Value

# Import the spreadsheet
$importParams = @{
    Path           = $excelFile
    WorksheetName  = 'ProjectTemplate'
    StartRow       = $startRow
    EndRow         = $endRow
    StartColumn    = $startColumn
    EndColumn      = $endColumn
}
$tags = Import-Excel @importParams

# Convert to Hashtable
$tag = @{}
$tags.GetEnumerator()| ForEach-Object { $tag[$_.name] = $_.value }

#endregion

#region Code from 06-02 - Create the resources
$data.foreach{
    $resource = $_
    # Create the resource based on its type
    switch ($resource.Type) {
        'Resource Group' {
            Write-Output ("Creating Resource Group: {0} in Location: {1}" -f $resource.Name, $resource.Location)
            $resourceGroup = $resource.Name
            New-AzResourceGroup -Name $resource.Name -Location $resource.Location -Tag $tag
        }
        'Storage Account' {
            $storageParams = @{
                Name                 = $resource.Name.ToLower()
                ResourceGroupName    = $resourceGroup
                Location             = $resource.Location
                Tag                  = $tag
            }
            Write-Output ("Creating Storage Account: {0} in Resource Group: {1}" -f $resource.Name, $resourceGroup)
            if($resource.Properties) {
                $resource.Properties.split(';').foreach{
                    $keyValue = $_.Split('=')
                    $storageParams.Add($keyValue[0], $keyValue[1])
                }
            }
            Write-Output ("Creating Storage Account: {0} in Resource Group: {1}" -f $resource.Name, $resourceGroup)
            $str = New-AzStorageAccount @storageParams
            Write-Output ("Storage Account created with Name: {0}" -f $str.StorageAccountName)
        }
        'Key Vault' {
            $keyVaultParams = @{
                Name                 = $resource.Name
                ResourceGroupName    = $resourceGroup
                Location             = $resource.Location
                Tag                  = $tag
            }
            Write-Output $resource.Name
            if($resource.Properties) {
                $resource.Properties.split(';').foreach{
                    $keyValue = $_.Split('=')
                    $keyVaultParams.Add($keyValue[0], $keyValue[1])
                }
            }
            Write-Output ("Creating Key Vault: {0} in Resource Group: {1}" -f $resource.Name, $resourceGroup)
            $kv = New-AzKeyVault @keyVaultParams
            Write-Output ("Key Vault created with URI: {0}" -f $kv.VaultUri)
        }
        default {
            Write-Output ("Unknown resource type: {0}" -f $resource.Type)
        }
    }
}
#endregion