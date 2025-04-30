

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
