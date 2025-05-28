# Find VM SKUs

    # 1. Get the Image Publisher
    Get-AzVMImagePublisher -Location UKSouth | Out-GridView

    # 2. Get the Image Offer
    Get-AzVMImageOffer -location UKSouth -PublisherName MicrosoftSQLServer | Out-GridView

    # 3. Get the SKU
    Get-AzVMImageSku -Location UKSouth -PublisherName 'MicrosoftSQLServer' -Offer 'sql2025-ws2025'
