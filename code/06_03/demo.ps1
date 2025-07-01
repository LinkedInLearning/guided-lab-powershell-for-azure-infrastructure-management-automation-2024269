Set-Location .\code\06_03

$data.foreach{
    $resource = $_
    # Create the resource based on its type
    switch ($resource.Type) {
        'Resource Group' {
            Write-Output ("Testing Resource Group: {0}" -f $resource.Name)
            $resourceGroup = $resource.Name
            $container = New-PesterContainer -Path .\tests\rg.tests.ps1 -Data @{ data = $resource }
            Invoke-Pester -Container $container -Output Detailed        
        }
        'Storage Account' {
            Write-Output ("Testing Storage Account: {0} in Resource Group: {1}" -f $resource.Name, $resourceGroup)
            $container = New-PesterContainer -Path .\tests\storage.tests.ps1 -Data @{ data = $resource; rgName = $resourceGroup }
            Invoke-Pester -Container $container -Output Detailed        
        }
        'Key Vault' {
            Write-Output ("Testing Key Vault: {0} in Resource Group: {1}" -f $resource.Name, $resourceGroup)
            $container = New-PesterContainer -Path .\tests\kv.tests.ps1 -Data @{ data = $resource; rgName = $resourceGroup }
            Invoke-Pester -Container $container -Output Detailed        
        }
    }
}

# run generic tests
$container = New-PesterContainer -Path .\tests\generic.tests.ps1 -Data @{ rgName = $resourceGroup; tag = $tag.Keys }
Invoke-Pester -Container $container -Output Detailed