# MonitorGlobalAdmins.ps1
Connect-AzAccount
$roles = Get-AzRoleAssignment | Where-Object { $_.RoleDefinitionName -eq "Global Administrator" }
$roles | Select-Object DisplayName, UserPrincipalName, RoleDefinitionName | Export-Csv -Path "RoleAudit_$(Get-Date -Format yyyyMMdd).csv" -NoTypeInformation
Write-Output "Audit completed. Results saved to RoleAudit_$(Get-Date -Format yyyyMMdd).csv"
