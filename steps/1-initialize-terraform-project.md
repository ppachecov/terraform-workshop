# Initialize Terraform project

Now we have everything we need to start deploying infrastructure using Terraform. You will use this, to provision, update and destroy a simple project based on a Google Cloud Function that uses a Redis as a memory store. You will learn about [HCL](https://github.com/hashicorp/hcl), provider configurations, and input variables.

## Provider configuration

> **What are providers?**: "Terraform relies on plugins called "providers" to interact with cloud providers, SaaS providers, and other APIs.

Terraform configurations must declare which providers they require so that Terraform can install and use them. Additionally, some providers require configuration (like endpoint URLs or cloud regions) before they can be used."

To learn more, reference the [providers documentation.](https://www.terraform.io/docs/language/providers/index.html)

Each terraform project must be in its own working directory. Create and change into a directory for your project.

```shell
mkdir terraform-gcp-workshop && cd terraform-gcp-workshop
```

Terraform loads all files ending in .tf or .tf.json in the working directory. Create a provider.tf file for your configuration.

```shell
touch provider.tf
```

ℹ️  `.tf` files use [HCL](https://github.com/hashicorp/hcl) as a programing language to describe infrastructure resources and configurations.

> **What is HCL?**: "The HashiCorp Configuration Language (HCL) is a configuration language authored by HashiCorp. HCL is used with HashiCorp’s cloud infrastructure automation tools, such as Terraform. The language was created with the goal of being both human and machine friendly. It is JSON compatible, which means it is interoperable with other systems outside of the Terraform product line."

Open `provider.tf` in your text editor, and paste in the configuration below. Be sure to replace `<NAME>` with the path to the service account key file provided by the moderator created in the **"Initialize accounts"** step.

```hcl
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">=3.88.0"
    }
  }

  required_version = ">= 1.0.9"
}

provider "google" {
  credentials = file("<NAME>.json")

  project = <PROJECT_ID>
  region  = "us-east1"
  zone    = "us-east1-c"
}
```

### What is described into the file?

---

#### Terraform block

The `terraform {}` block contains Terraform settings, including the required providers Terraform will use to provision your infrastructure. For each provider, the source attribute defines an optional hostname, a namespace, and the provider type. Terraform installs providers from the [Terraform Registry](https://registry.terraform.io/) by default.

#### Providers blocks

The `provider "<NAME>" {}` block configures the specified provider, in this case **google**. A provider is a plugin that Terraform uses to create and manage your resources. You can define multiple provider blocks in a Terraform configuration to manage resources from different providers.

To learn more, reference the [Google provider documentation.](https://registry.terraform.io/providers/hashicorp/google/latest/docs)

### Initialize the directory

---

When you create a new configuration — or check out an existing configuration from version control — you need to initialize the directory with `terraform init` command. This step downloads the providers defined in the configuration.

```shell
$ terraform init

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/google versions matching ">= 3.88.0"...
- Installing hashicorp/google v3.89.0...
- Installed hashicorp/google v3.89.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

Terraform downloads the **google** provider and installs it in a hidden subdirectory of your current working directory, named `.terraform`. The `terraform init` command prints the provider version Terraform installed. Terraform also creates a lock file named `.terraform.lock.hcl`, which specifies the exact provider versions used to ensure that every Terraform run is consistent. This also allows you to control when you want to upgrade the providers used in your configuration.

### Additional commands

- `terraform fmt` to format terraform files.

[Next Step - Deploy resources](./2-deploy-resources.md)