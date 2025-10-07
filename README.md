# aws-iam-role-checker
This repository holds a GitHub Actions workflow that checks if specific IAM roles exist in your AWS account. It’s safe, reusable, and automated using OpenID Connect (OIDC) (so no AWS keys in GitHub Secrets).


# 🛡️ AWS IAM Role Checker (GitHub Actions + OIDC)

This repository contains a **GitHub Actions workflow** that automatically checks whether specific IAM roles exist in your AWS account.  
It uses **OpenID Connect (OIDC)** for authentication — meaning **no long-lived AWS access keys** are stored in GitHub Secrets.  
Secure, automated, and reusable across multiple AWS environments.

---

## 🚀 Features
- ✅ **No AWS credentials** — uses GitHub’s OIDC federation for secure role assumption.  
- 🔄 **Reusable workflow** — easily extended to multiple AWS accounts or regions.  
- 🔍 **Automated validation** — verifies if specific IAM roles exist in your account(s).  
- 💥 **Fails automatically** if any required role is missing.  
- 🧩 **Configuration-driven** — all inputs are stored in a `config/config.yml` file.

---

## 🗂️ Repository Structure

```
.
├── .github/
│ └── workflows/
│ └── check-iam-roles.yml # Main GitHub Actions workflow
└── config/
└── config.yml # Contains account, region, and role configuration
```


---

## ⚙️ Configuration

### `config/config.yml`
Define your AWS accounts, regions, and IAM roles to check:
```yaml
inputs:
  aws_accounts: "111111111111"
  aws_regions: "us-east-1,ap-south-1"
  role_names: "AdminRole,DeveloperRole,TestRole"
```


You can add multiple accounts or roles later:
```
inputs:
  aws_accounts: "111111111111,222222222222"
  role_names: "AdminRole,DevRole,OpsRole"
```


---

**🧠 How It Works**

1. GitHub Actions runs on demand using the workflow_dispatch trigger.

2. It reads your AWS configuration from config/config.yml.

3. Authenticates securely to AWS via OIDC, assuming a pre-configured IAM role.

4. Checks if each listed IAM role exists in all specified accounts and regions.

5. Generates a clear summary:

- ✅ Role exists → Success

- ❌ Role missing → Fails workflow


---

**🔒 Security Setup**
1. Create an OIDC Provider in AWS

AWS Console → IAM → Identity Providers → Add Provider

- Provider Type: OpenID Connect

- Provider URL: https://token.actions.githubusercontent.com

- Audience: sts.amazonaws.com

2. Create an IAM Role for GitHub OIDC

Example trust policy:
```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::<YOUR_ACCOUNT_ID>:oidc-provider/token.actions.githubusercontent.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringLike": {
          "token.actions.githubusercontent.com:sub": "repo:Kalyani-Bambal/aws-iam-role-checker:ref:refs/heads/main"
        }
      }
    }
  ]
}
```

Example IAM policy for that role:
```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["iam:GetRole", "iam:ListRoles"],
      "Resource": "*"
    }
  ]
}
```


---

**▶️ Usage**

1. Go to the Actions tab in GitHub.

2. Select “AWS IAM Role Checker” → “Run workflow”.

3. The job runs automatically using the config/config.yml values.

4. Review the workflow logs for the success or failure summary.


---

**🧩 Future Enhancements**

- 🔁 Dynamic multi-account role assumption (different OIDC roles per account).

- 🧾 Automated reporting via Slack or email.

- 🌐 Integration with Terraform for pre-deployment validation.


---

