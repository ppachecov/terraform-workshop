# Deploy resources

Now that we have our project configured with our provider, we have to deploy the resources related to our project.

## Cloud function

Before to deploy infrastructure, we need to create the function we need to run, this time we will create a **hello world** function.

Create a folder called `code`.

```shell
mkdir code && cd code
```

Create an `index.js` file.

```shell
touch index.js
```

Open in you text editor and paste in the code below.

```javascript
const escapeHtml = require('escape-html');

/**
 * HTTP Cloud Function.
 *
 * @param {Object} req Cloud Function request context.
 *                     More info: https://expressjs.com/en/api.html#req
 * @param {Object} res Cloud Function response context.
 *                     More info: https://expressjs.com/en/api.html#res
 */
exports.helloGET = (req, res) => {
  res.send(`Hello ${escapeHtml(req.query.name || 'World')}!`);
};
```

This will create a function called `helloGET` that will print `Hello World` if the name is empty.

Create the `package.json` file into the same `code`folder.

```shell
touch package.json
```

Open `package.json` file with your text editor and paste in the code below. This will manage all the dependencies need it.

```json
{
  "name": "sample-hello-world",
  "version": "0.0.1",
  "private": true,
  "engines": {
    "node": ">=12.0.0"
  },
  "scripts": {
    "unit-test": "mocha test/index.test.js test/*unit*test.js test/*integration*test.js --timeout=6000 --exit",
    "system-test": "mocha test/*system*test.js --timeout=600000 --exit",
    "all-test": "npm run unit-test && npm run system-test",
    "test": "npm -- run all-test"
  },
  "dependencies": {
    "@google-cloud/debug-agent": "^5.0.0",
    "escape-html": "^1.0.3"
  },
  "devDependencies": {
    "@google-cloud/functions-framework": "^1.1.1",
    "@google-cloud/pubsub": "^2.0.0",
    "@google-cloud/storage": "^5.0.0",
    "gaxios": "^4.3.0",
    "mocha": "^9.0.0",
    "moment": "^2.24.0",
    "promise-retry": "^2.0.0",
    "sinon": "^11.0.0",
    "supertest": "^6.0.0",
    "uuid": "^8.0.0",
    "wait-port": "^0.2.9"
  }
}
```

Compress files as a **zip** file.

```shell
zip index.zip index.js package.json
```

## Create the infraestructure need it

Now we can create the infrastructure need it. Create a `cloud-function.tf` file.

```shell
$ touch cloud-function.tf
```

Open `clud-function.tf` file with your text editor and paste in the code below. Be sure to change <USER_NAME> with your test username for this workshop.

```hcl
resource "google_storage_bucket" "bucket" {
  name = "<USER_NAME>-bucket"
}

resource "google_storage_bucket_object" "archive" {
  name   = "index.zip"
  bucket = google_storage_bucket.bucket.name
  source = "./code"
}

resource "google_cloudfunctions_function" "function" {
  name        = "function-test-<USER_NAME>"
  description = "Hello world function for workshop"
  runtime     = "nodejs14"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.archive.name
  trigger_http          = true
  entry_point           = "helloGET"
}

# IAM entry for all users to invoke the function
resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = google_cloudfunctions_function.function.project
  region         = google_cloudfunctions_function.function.region
  cloud_function = google_cloudfunctions_function.function.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}
```

### What is described into the file?

#### google_storage_bucket resource

This is a bucket need it to host the code references into the function.

#### google_storage_bucket_object resource

This is the function code itself, is an object uploaded into the bucket.

#### google_cloudfunctions_function resource

This is the function definition, with the reference to the bucket that hold the code of the function and the code zipped.

#### google_cloudfunctions_function_iam_member resource

This is the trigger of the function based on http requests.

### Deploy the infraestructure need it

Let explore the terraform action to be deployed.

```shell
terraform plan
```

When you run `terraform plan` command Terraform describe all the changes it going to perform, you can use this step be sure of the changes you want to deploy.

```shell
terraform plan                  

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # google_cloudfunctions_function.function will be created
  + resource "google_cloudfunctions_function" "function" {
      + available_memory_mb           = 128
      + description                   = "Hello world function for workshop"
      + entry_point                   = "helloGET"
      + https_trigger_url             = (known after apply)
      + id                            = (known after apply)
      + ingress_settings              = "ALLOW_ALL"
      + max_instances                 = 0
      + name                          = "function-test-<USER_NAME>"
      + project                       = (known after apply)
      + region                        = (known after apply)
      + runtime                       = "nodejs14"
      + service_account_email         = (known after apply)
      + source_archive_bucket         = "<USER_NAME>-bucket"
      + source_archive_object         = "index.zip"
      + timeout                       = 60
      + trigger_http                  = true
      + vpc_connector_egress_settings = (known after apply)

      + event_trigger {
          + event_type = (known after apply)
          + resource   = (known after apply)

          + failure_policy {
              + retry = (known after apply)
            }
        }
    }

  # google_cloudfunctions_function_iam_member.invoker will be created
  + resource "google_cloudfunctions_function_iam_member" "invoker" {
      + cloud_function = "function-test-<USER_NAME>"
      + etag           = (known after apply)
      + id             = (known after apply)
      + member         = "allUsers"
      + project        = (known after apply)
      + region         = (known after apply)
      + role           = "roles/cloudfunctions.invoker"
    }

  # google_storage_bucket.bucket will be created
  + resource "google_storage_bucket" "bucket" {
      + bucket_policy_only          = (known after apply)
      + force_destroy               = false
      + id                          = (known after apply)
      + location                    = "US"
      + name                        = "<USER_NAME>-bucket"
      + project                     = (known after apply)
      + self_link                   = (known after apply)
      + storage_class               = "STANDARD"
      + uniform_bucket_level_access = (known after apply)
      + url                         = (known after apply)
    }

  # google_storage_bucket_object.archive will be created
  + resource "google_storage_bucket_object" "archive" {
      + bucket         = "<USER_NAME>-bucket"
      + content_type   = (known after apply)
      + crc32c         = (known after apply)
      + detect_md5hash = "different hash"
      + id             = (known after apply)
      + kms_key_name   = (known after apply)
      + md5hash        = (known after apply)
      + media_link     = (known after apply)
      + name           = "index.zip"
      + output_name    = (known after apply)
      + self_link      = (known after apply)
      + source         = "./code/index.zip"
      + storage_class  = (known after apply)
    }

Plan: 4 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + url = (known after apply)

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```

Save this plan to ensure the changes reviewed.

```shell
terraform -out .terraform-plan
```

Deploy the function with all its components.

```shell
terraform apply ".terraform-plan"
```

When you run `terraform apply` command Terraform perform the plan reviwed and apply all the change into the cloud provider and create all recources.

```shell
terraform apply ".terraform-plan"  
google_storage_bucket.bucket: Creating...
google_storage_bucket.bucket: Creation complete after 2s [id=<USER_NAME>-bucket]
google_storage_bucket_object.archive: Creating...
google_storage_bucket_object.archive: Creation complete after 0s [id=<USER_NAME>-bucket-index.zip]
google_cloudfunctions_function.function: Creating...
google_cloudfunctions_function.function: Still creating... [2m10s elapsed]
google_cloudfunctions_function.function: Creation complete after 2m20s [id=projects/<PROJECT_ID>/locations/us-east1/functions/function-test-<USER_NAME>]
google_cloudfunctions_function_iam_member.invoker: Creating...
google_cloudfunctions_function_iam_member.invoker: Creation complete after 6s [id=projects/<PROJECT_ID>/locations/us-east1/functions/function-test-<USER_NAME>/roles/cloudfunctions.invoker/allUsers]

Apply complete! Resources: 4 added, 0 changed, 0 destroyed.
```

### Getting data from the resources

To get feedback from the resources and can interact with them, we need to define output variables.

Create an `output.tf` file.

```shell
touch output.tf
```

Open `output.tf` file with your text editor and paste in the code below.

```hcl
output "url" {
  value = google_cloudfunctions_function.function.https_trigger_url
}
```

### What is into the file?

**output "url" block**
Expose the http url to trigger the function.

**Output values**
Resource instances managed by Terraform each export attributes whose values can be used elsewhere in configuration. Output values are a way to expose some of that information to the user of your module.

To learn more, references to [Terraform output values documentation](https://www.terraform.io/docs/language/values/outputs.html)

### Interacting with outputs

Re run terraform apply with the `output.tf` file.

```shell
terraform apply ".terraform-plan"
 
google_storage_bucket.bucket: Creating...
google_storage_bucket.bucket: Creation complete after 2s [id=<USER_NAME>-bucket]
google_storage_bucket_object.archive: Creating...
google_storage_bucket_object.archive: Creation complete after 0s [id=<USER_NAME>-bucket-index.zip]
google_cloudfunctions_function.function: Creating...
google_cloudfunctions_function.function: Still creating... [2m10s elapsed]
google_cloudfunctions_function.function: Creation complete after 2m20s [id=projects/<PROJECT_ID>/locations/us-east1/functions/function-test-<USER_NAME>]
google_cloudfunctions_function_iam_member.invoker: Creating...
google_cloudfunctions_function_iam_member.invoker: Creation complete after 6s [id=projects/<PROJECT_ID>/locations/us-east1/functions/function-test-<USER_NAME>/roles/cloudfunctions.invoker/allUsers]

Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

Outputs:

url = "https://us-east1-<PROJECT_ID>.cloudfunctions.net/function-test-<USER_NAME>"
```

We can see the output section now with the value exposed from the resource.

Print the output.

```shell
terraform output -json
```

```shell
{
  "url": {
    "sensitive": false,
    "type": "string",
    "value": "https://us-east1-<PROJECT_ID>.cloudfunctions.net/function-test-<USER_NAME>"
  }
}
```

To lear more, reference to [Terraform output comand documentation](https://www.terraform.io/docs/cli/commands/output.html)

---

[Next Step - Deploy resources](./3-terraform-state.md)