# Create an Azure Automation account
$autoParams = @{
    Name = 'aa-linkedinpwsh-prod-001'
    ResourceGroupName = 'rg-linkedinpwsh-prod-001'
    Location = 'UKSouth'
    Plan = 'Free'
}
New-AzAutomationAccount @autoParams

# Create a PowerShell Runbook
$runbookParams = @{
    Name = 'RunPowerShellInTheCloud'
    ResourceGroupName = 'rg-linkedinpwsh-prod-001'
    AutomationAccountName = 'aa-linkedinpwsh-prod-001'
    Type = 'PowerShell'
    Description = 'This is a runbook where we can run PowerShell code'
}
New-AzAutomationRunbook @runbookParams