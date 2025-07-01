param (    
    [Parameter(Mandatory)]
    [string]$rgName,
    
    [Parameter(Mandatory)]
    [string[]]$tag
) 
Describe "Azure Resources in resource group $rgName have tags" {
    $res = Get-AzResource -ResourceGroupName $rgName | Select-Object Name, ResourceId, Tags
    Context '<_.Name> should have tags' -Foreach $res { 
        BeforeAll {
            $resource = $_
        }

        It "<_.Name> should have tags" {
            $resource.Tags | Should -Not -BeNullOrEmpty
        }
        
        It "resource should have <_> tag" -Foreach $tag {
            $resource.Tags.Keys | Should -Contain $_
        }
    }
}
