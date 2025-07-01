param (    
    [Parameter(Mandatory)]
    [string]$rgName,
    
    [Parameter(Mandatory)]
    [Hashtable]$tag
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
        
        It "resource should have <tagName> tag" -Foreach @(
            @{tagName = 'environment'},
            @{tagName = 'author'},
            @{tagName = 'costs'}
        )  {
        #-Skip:($null -eq $resource.Tags)
            # We already checked if Tags exists in a separate test, so we can safely access Keys here
            $resource.Tags.Keys | Should -Contain $tagName
        }
    }
}
