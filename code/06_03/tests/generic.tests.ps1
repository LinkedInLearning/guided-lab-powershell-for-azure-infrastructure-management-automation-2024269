param (    
    [Parameter(Mandatory)]
    [string]$rgName
)
Describe "Azure Resources in resource group $rgName have tags" {
    BeforeAll {
        $res = Get-AzResource -ResourceGroupName $rgName
        $res | ogv
        $requiredTags = @('environment','author','costs') 
    }        
    Context '<_.Name> should have tags'  -Foreach $res {   
        It "resource should have <_> tag" -Foreach  @('environment','author','costs')  {
            $_.Tags.Keys | Should -Contain $_
        }
    }

}
