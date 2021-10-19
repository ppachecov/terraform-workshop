# Terraform workshop - GCP

This workshop is designed as an introduction to terraform as an [IaC](https://www.redhat.com/en/topics/automation/what-is-infrastructure-as-code-iac) tool.

## Pre-requisites

> ⚠️ All the commands presented in this workshop are designed to be executed in a macOS or Linux system.

- Install [terraform cli](https://www.terraform.io/downloads.html).
- Install [VSCode](https://code.visualstudio.com) or some other editor.

## Initialize accounts

> ℹ️ This section is for the moderator only. Remember, you need a master credential for GCP.

To interact with the tool and the Google Cloud to provision infrastructure, we need to set up a couple of service accounts for every participant in the workshop. To do this run the **"terraform-init"** scripts. Be sure to replace `<PROJECT_ID>` with a valid project's ID.

```shell
$ export TF_VAR_gcp_project_id=<PROJECT_ID>
$ export GOOGLE_CREDENTIALS=../secret/credential.json
$ terraform -chdir=terraform-init init
$ terraform -chdir=terraform-init apply
```

Once created, assign one sa to each participant.

```shell
$ terraform -chdir=terraform-init output -json > secret/keys.json
```

## Workshop

**Steps:**

1. [Initialize terraform project](steps/1-initialize-terraform-project.md)
2. [Deploy resources - plan, apply, destroy](steps/2-deploy-resources.md)
3. [Project configuration and deploy - state, output](steps/3-project-configuration-and.deploy.md)
4. [Clean up and next steps](steps/4-clean-up-and-next-steps.md)

## Destroy accounts

Remember destroy the service accounts created for this workshop.

```shell
$ terraform -chdir=terraform-init destroy
```

---

## Interested links

- [Terraform get started - Google Cloud](https://learn.hashicorp.com/collections/terraform/gcp-get-started).
- [Keybase](https://keybase.io) end-to-end encryption, suitable for secret sharing within your team.
- [Terraform registry](https://registry.terraform.io) to search terraform modules.