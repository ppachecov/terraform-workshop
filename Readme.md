# Terraform workshop - GCP

This workshop is designed as an introduction to terraform as an [IaC](https://www.redhat.com/en/topics/automation/what-is-infrastructure-as-code-iac) tool.

## Pre-requisites

> ⚠️ All the commands presented in this workshop are designed to be executed in a macOS or Linux system.

- Install [terraform cli](https://www.terraform.io/downloads.html).
- Install [VSCode](https://code.visualstudio.com) or some other editor.

## Initialize accounts

> ℹ️ This section is for the moderator only. Remember, you need a master credential for GCP.

To interact with the tool and the Google Cloud to provision infrastructure, we need to set up a couple of service accounts for every participant in the workshop. To do this run the **"terraform-init"** scripts.

```bash
export GOOGLE_CREDENTIALS=../secret/credential.json
terraform -chdir=terraform-init init
terraform -chdir=terraform-init apply
```

Once created, assign one sa to each participant.

```bash
terraform -chdir=terraform-init output -json > secret/keys.json
```

## Workshop

**Steps:**

1. [Initialize terraform project](steps/1-initialize-terraform-project.md)
2. [Deploy first resource - plan, apply, destroy](steps/2-deploy-first-resource.md)
3. [Project configuration and deploy - state, output](steps/3-project-configuration-and.deploy.md)
4. [Clean up](steps/4-clean-up.md)

## Destroy accounts

Remember destroy the service accounts created for this workshop.

```bash
terraform -chdir=terraform-init destroy
```

---

## Interested links

- [Terraform get started - Google Cloud](https://learn.hashicorp.com/collections/terraform/gcp-get-started).
- [Keybase](https://keybase.io) end-to-end encryption, suitable for secret sharing within your team.
- [Terraform registry](https://registry.terraform.io) to search terraform modules.