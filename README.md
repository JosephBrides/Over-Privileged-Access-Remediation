

# Over-Privileged Access Remediation and Access Review Setup

## 🚀 Project Overview
This project demonstrates the remediation of an over-privileged test user account with **Global Administrator** privileges in **Microsoft Entra ID**, identified during a mock internal audit. It enforces the **principle of least privilege** and implements **access reviews** to maintain compliance, aligning with **Zero Trust** security practices.

### Objectives
- Remove **Global Administrator** privileges from the test user.
- Assign appropriate roles based on user requirements.
- Set up periodic **access reviews** using **Microsoft Identity Governance**.
- Automate role monitoring with **PowerShell**.
- Document the process for portfolio showcase.

### Technologies Used
- **Microsoft Entra ID** (Azure Portal)
- **Azure Role-Based Access Control (RBAC)**
- **Microsoft Identity Governance** (Access Reviews)
- **PowerShell** (for automation)
- **Azure Free Tier** (for lab environment)

## 🛠️ Lab Setup
### Prerequisites
- **Hardware**: Laptop with 16GB RAM, 500GB SSD, multi-core CPU.
- **Software**: Azure Portal access, PowerShell (with `Az` module installed: `Install-Module -Name Az`).
- **Azure Account**: Free Azure account with an Entra ID tenant ([sign up here](https://azure.microsoft.com/free)).
- **Virtualization**: VirtualBox or VMware Workstation (optional for local AD testing).

### Step-by-Step Setup
1. **Create Azure Tenant and Test User**:
   - Sign up for a free Azure account at [portal.azure.com](https://portal.azure.com).
   - Navigate to **Entra ID > Overview** and note your tenant ID.
   - Go to **Entra ID > Users > New user**.
   - Create a test user (e.g., `testuser@yourdomain.onmicrosoft.com`).
   - Assign the **Global Administrator** role to simulate the audit finding:
     - Go to **Entra ID > Roles and administrators > Global Administrator**.
     - Click **Add assignments**, select the test user, and assign.

2. **Install PowerShell and Az Module**:
   - On a Windows machine, open PowerShell as Administrator.
   - Install the Az module:
     ```powershell
     Install-Module -Name Az -Scope CurrentUser -Force


Connect to Azure:

powershell

Connect-AzAccount

🔍 Lab Execution
Phase 1: Remediate Over-Privileged Access

    Identify Over-Privileged User:
        In Azure Portal, go to Entra ID > Users, locate testuser.
        Check roles under Entra ID > Roles and administrators > Global Administrator.
        Confirm the test user has Global Administrator privileges.
    Determine Required Role:
        Assess the test user’s needs (e.g., standard user, no admin access).
        Select the least privileged role (e.g., User role).
    Remove Global Administrator Role:
        In Entra ID > Roles and administrators > Global Administrator, select the test user.
        Click Remove assignment.
        Assign the User role via Entra ID > Users > testuser > Assigned roles > Add role assignment.
    Validate Remediation:
        Log in as testuser in a private browser window.
        Attempt to access restricted areas (e.g., Entra ID settings). Confirm access is denied.

Phase 2: Audit All Accounts

    List Users with Elevated Roles:
        Run PowerShell command to audit Global Administrator roles:
        powershell

    Get-AzADUser -Filter "assignedRoles/any(r:r/roleName eq 'Global Administrator')" | Export-Csv -Path "GlobalAdmins.csv" -NoTypeInformation
    Review the CSV file to identify other over-privileged accounts.
    Outcome: Identified 3 additional users with unnecessary Global Administrator roles.

Adjust Roles:

    For each user, verify job function and reassign to appropriate roles (e.g., User Administrator for HR team).
    Document changes in a changelog:
    markdown

        ### Changelog
        - 2025-04-30: Removed Global Administrator from hr_user1, assigned User Administrator.
        - 2025-04-30: Removed Global Administrator from dev_user2, assigned Application Administrator.

Phase 3: Configure Access Reviews

    Set Up Access Reviews:
        Navigate to Entra ID > Identity Governance > Access reviews > Create access review.
        Configure:
            Name: Global Administrator Access Review
            Scope: Global Administrator role
            Frequency: Quarterly
            Reviewers: Security Team (or your admin account in lab)
            Fallback Reviewer: Your admin account
        Enable email notifications.
    Test Access Review:
        Start the review from Identity Governance > Access reviews.
        As the reviewer, approve or deny each user’s role assignment.
        Check results in Access reviews > Results.
        Outcome: Confirmed 2 users retained Global Administrator role; 1 user’s access revoked.

Phase 4: Automate Role Monitoring

    Create PowerShell Script:
        Write a script to monitor Global Administrator assignments:
        powershell

        # MonitorGlobalAdmins.ps1
        Connect-AzAccount
        $roles = Get-AzRoleAssignment | Where-Object { $_.RoleDefinitionName -eq "Global Administrator" }
        $roles | Select-Object DisplayName, UserPrincipalName, RoleDefinitionName | Export-Csv -Path "RoleAudit_$(Get-Date -Format yyyyMMdd).csv" -NoTypeInformation
        Write-Output "Audit completed. Results saved to RoleAudit_$(Get-Date -Format yyyyMMdd).csv"
        Save as MonitorGlobalAdmins.ps1 in the repository.
    Schedule the Script:
        Use Windows Task Scheduler to run the script weekly:
            Open Task Scheduler, create a new task.
            Set trigger to weekly (e.g., every Monday at 9 AM).
            Set action to run powershell.exe -File "C:\path\to\MonitorGlobalAdmins.ps1".
        Outcome: Automated weekly audits, with CSV reports stored in the repository.

📊 Results

    Remediation: Successfully removed Global Administrator privileges from testuser and 3 other accounts, enforcing least privilege.
    Access Reviews: Quarterly reviews implemented, with 1 unnecessary role revoked in the first cycle.
    Automation: Weekly role audits scripted and scheduled, generating CSV reports.
    Skills Demonstrated:
        Entra ID role management
        Identity Governance configuration
        PowerShell scripting
        Zero Trust and least privilege principles

📝 Lessons Learned

    Challenge: Initially faced “Access Denied” errors when removing roles due to insufficient permissions.
        Solution: Used a Global Administrator account to perform role changes.
    Insight: Regular access reviews are critical to prevent privilege creep.
    Improvement: Plan to integrate Azure Logic Apps for automated email alerts on audit findings.

