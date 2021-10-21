# Improvements and clean up

Now we have our function working properly, let's improve our deployment to be more flexible and reproducible.

## Inputs variables

"Input variables serve as parameters for a Terraform module, allowing aspects of the module to be customized without altering the module's own source code, and allowing modules to be shared between different configurations.

When you declare variables in the root module of your configuration, you can set their values using CLI options and environment variables. When you declare them in child modules, the calling module should pass values in the module block."

To lear more, reference to [Terraform input variables documentation](https://www.terraform.io/docs/language/values/variables.html)

> Each input variable must be declared using a variable block

First, destroy our infra.

```shell
terraform destroy
```

Create a `variables.tf` file.

```shell
touch variables.tf
```

Open in your text editor and paste in the code below.

```hcl
variable "project_id" {
  description = "Google project id"
}

variable "region" {
  default = "us-east1"
  description = "Google availability region"
}

variable "zone" {
  default = "us-east1-c"
  description = "Google availability zone whitin a region"
}

variable "db_name" {
  default = "workshop-test"
  description = "DB name"
}

variable "db_username" {
  default = "test"
  description = "DB user name"
}

variable "workshop_user" {
  description = "DB user name"
}
```

This will let us replay this recipe several time changing the configuration variables.

You can browse the final code in the folder `terraform-final` copy and paste it into your project.

let's deploy everything again using variables. We can run `terraform apply` and it will prompt to us for variable values or we can set them as environment variables. Be sure to replace <USER_NAME> and <PROJECT_ID> with valid values.

```shell
export TF_VAR_workshop_user=<USER_NAME>
export TF_VAR_project_id=<PROJECT_ID>

terraform apply --auto-approve
```

Test our function

```shell
FN=$(terraform output url)
curl FN
```

Remember destroy everything.

```shell
terraform destroy
```

That's it!

Happy coding.