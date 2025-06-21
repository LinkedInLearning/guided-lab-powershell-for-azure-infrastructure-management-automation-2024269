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
        # 'Key Vault' {
        #     $keyVaultParams = @{
        #         Name                 = $resource.Name
        #         ResourceGroupName    = $resourceGroup
        #         Location             = $resource.Location
        #     }
        #     Write-Output $resource.Name
        #     if($resource.Properties) {
        #         $resource.Properties.split(';').foreach{
        #             $keyValue = $_.Split('=')
        #             $keyVaultParams.Add($keyValue[0], $keyValue[1])
        #         }
        #     }
        #     Write-Output ("Creating Key Vault: {0} in Resource Group: {1}" -f $resource.Name, $resourceGroup)
        #     $kv = New-AzKeyVault @keyVaultParams
        #     Write-Output ("Key Vault created with URI: {0}" -f $kv.VaultUri)
        # }
        # default {
        #     Write-Output ("Unknown resource type: {0}" -f $resource.Type)
        # }
    }
}


