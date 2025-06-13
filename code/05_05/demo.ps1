# Get a resource group
$rg = Get-AzResourceGroup -Name rg-linkedinpwsh-prod-001

# Add a set of tags to a resource group
$Tags = @{
    "WorkloadName"="tagValue1"; 
    "DataClassification"="General";
    "Environment"="Production";
    "CostCenter"="Marketing";
    "Owner"="Jess Pomfret";
}
New-AzTag -ResourceId $rg.ResourceId -Tag $Tags
