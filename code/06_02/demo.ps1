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
            #TODO: this got created in wrong rg?
            $kv = New-AzKeyVault @keyVaultParams
            Write-Output ("Key Vault created with URI: {0}" -f $kv.VaultUri)
        }
        default {
            Write-Output ("Unknown resource type: {0}" -f $resource.Type)
        }
    }
}
