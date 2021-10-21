# Terraform state

"Terraform must store state about your managed infrastructure and configuration. This state is used by Terraform to map real world resources to your configuration, keep track of metadata, and to improve performance for large infrastructures.

This state is stored by default in a local file named "terraform.tfstate", but it can also be stored remotely, which works better in a team environment."

Open the `terraform.tfstate` file in your text editor. You will see something like the code below.

```json
{
  "version": 4,
  "terraform_version": "1.0.9",
  "serial": 187,
  "lineage": "c4edf3e1-85f0-42a0-bac0-f75b531163db",
  "outputs": {
    "url": {
      "value": "https://us-east1-<PROJECT_ID>.cloudfunctions.net/function-test-<USER_NAME>",
      "type": "string"
    }
  },
  "resources": [
    {
      "mode": "managed",
      "type": "google_cloudfunctions_function",
      "name": "function",
      "provider": "provider[\"registry.terraform.io/hashicorp/google\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "available_memory_mb": 128,
            "build_environment_variables": null,
            "description": "Hello world function for workshop",
            "entry_point": "helloGET",
            "environment_variables": {
              "DB_HOST": "<PROJECT_ID>:us-east1:<USER_NAME>-db-instance",
              "DB_NAME": "test",
              "DB_PASSWORD": "e80c805571522d1a",
              "DB_USER": "test"
            },
            "event_trigger": [],
            "https_trigger_url": "https://us-east1-<PROJECT_ID>.cloudfunctions.net/function-test-<USER_NAME>",
            "id": "projects/<PROJECT_ID>/locations/us-east1/functions/function-test-<USER_NAME>",
            "ingress_settings": "ALLOW_ALL",
            "labels": null,
            "max_instances": 0,
            "name": "function-test-<USER_NAME>",
            "project": "<PROJECT_ID>",
            "region": "us-east1",
            "runtime": "nodejs14",
            "service_account_email": "<PROJECT_ID>@appspot.gserviceaccount.com",
            "source_archive_bucket": "<USER_NAME>-bucket",
            "source_archive_object": "index.zip",
            "source_repository": [],
            "timeout": 60,
            "timeouts": null,
            "trigger_http": true,
            "vpc_connector": "",
            "vpc_connector_egress_settings": ""
          },
          "sensitive_attributes": [],
          "private": "...",
          "dependencies": [
            "google_sql_database_instance.master",
            "google_sql_user.default",
            "google_storage_bucket.bucket",
            "google_storage_bucket_object.archive",
            "random_id.user-password"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "google_cloudfunctions_function_iam_member",
      "name": "invoker",
      "provider": "provider[\"registry.terraform.io/hashicorp/google\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "cloud_function": "projects/<PROJECT_ID>/locations/us-east1/functions/function-test-<USER_NAME>",
            "condition": [],
            "etag": "BwXO3y59dXM=",
            "id": "projects/<PROJECT_ID>/locations/us-east1/functions/function-test-<USER_NAME>/roles/cloudfunctions.invoker/allUsers",
            "member": "allUsers",
            "project": "<PROJECT_ID>",
            "region": "us-east1",
            "role": "roles/cloudfunctions.invoker"
          },
          "sensitive_attributes": [],
          "private": "...",
          "dependencies": [
            "google_cloudfunctions_function.function",
            "google_sql_database_instance.master",
            "google_sql_user.default",
            "google_storage_bucket.bucket",
            "google_storage_bucket_object.archive",
            "random_id.user-password"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "google_storage_bucket",
      "name": "bucket",
      "provider": "provider[\"registry.terraform.io/hashicorp/google\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "bucket_policy_only": false,
            "cors": [],
            "default_event_based_hold": false,
            "encryption": [],
            "force_destroy": false,
            "id": "<USER_NAME>-bucket",
            "labels": {},
            "lifecycle_rule": [],
            "location": "US",
            "logging": [],
            "name": "<USER_NAME>-bucket",
            "project": "<PROJECT_ID>",
            "requester_pays": false,
            "retention_policy": [],
            "self_link": "https://www.googleapis.com/storage/v1/b/<USER_NAME>-bucket",
            "storage_class": "STANDARD",
            "uniform_bucket_level_access": false,
            "url": "gs://<USER_NAME>-bucket",
            "versioning": [],
            "website": []
          },
          "sensitive_attributes": [],
          "private": "..."
        }
      ]
    },
    {
      "mode": "managed",
      "type": "google_storage_bucket_object",
      "name": "archive",
      "provider": "provider[\"registry.terraform.io/hashicorp/google\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "bucket": "<USER_NAME>-bucket",
            "cache_control": "no-cache",
            "content": null,
            "content_disposition": "",
            "content_encoding": "",
            "content_language": "",
            "content_type": "application/zip",
            "crc32c": "FAHeBg==",
            "customer_encryption": [],
            "detect_md5hash": "UDqvL0dFyn1POh198vhOVg==",
            "event_based_hold": false,
            "id": "<USER_NAME>-bucket-index.zip",
            "kms_key_name": "",
            "md5hash": "UDqvL0dFyn1POh198vhOVg==",
            "media_link": "https://storage.googleapis.com/download/storage/v1/b/<USER_NAME>-bucket/o/index.zip?generation=1634832673125214\u0026alt=media",
            "metadata": null,
            "name": "index.zip",
            "output_name": "index.zip",
            "self_link": "https://www.googleapis.com/storage/v1/b/<USER_NAME>-bucket/o/index.zip",
            "source": "./code/index.zip",
            "storage_class": "STANDARD",
            "temporary_hold": false,
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "...",
          "dependencies": [
            "google_storage_bucket.bucket"
          ]
        }
      ]
    },
  ]
}

```

This is how Terraform handle the resources described on your project.

To lear more, reference to [Terraform state documentation](https://www.terraform.io/docs/language/state/index.html)

## Interact with the state and perform some changes

"The terraform state command is used for advanced state management. As your Terraform usage becomes more advanced, there are some cases where you may need to modify the Terraform state. Rather than modify the state directly, the terraform state commands can be used in many cases instead."

Lets list all the resources we have.

```shell
terraform state list
```

Lets inspect our function.

```shell
terraform state show 'google_cloudfunctions_function.function'
```

Lets make some changes. Create a `postgre.tf` file.

```hcl
resource "google_sql_database" "database" {
  name     = "test"
  instance = google_sql_database_instance.master.name
}

resource "google_sql_database_instance" "master" {
  name             = "<USER_NAME>-db-instance"
  database_version = "POSTGRES_11"
  region           = "us-east1"

  settings {
    tier = "db-f1-micro"
  }

  timeouts {
    create = "60m"
    delete = "2h"
  }
}

resource "random_id" "user-password" {
  keepers = {
    name = google_sql_database_instance.master.name
  }

  byte_length = 8
  depends_on  = [google_sql_database_instance.master]
}

resource "google_sql_user" "default" {
  name       = "test"
  instance   = google_sql_database_instance.master.name
  password   = random_id.user-password.hex
  depends_on = [google_sql_database_instance.master]
}
```

### What is described into the file?

#### google_sql_database_instance

Creates a new Google SQL Database Instance. For more information about Cloud SQL, see the [official documentation](https://cloud.google.com/sql/)

#### google_sql_database

Creates a database into the Cloud SQL instance

#### google_sql_user

Register a new user into the database instance

#### random_id

Creates an string of random characters that we use in this case as a password for our sql user

### Connect with our function

To use this Cloud SQL within our function, we have to pass the connection as environment variables.

Add environemtn variables to `cloud-function.tf` file.

```hcl
resource "google_cloudfunctions_function" "function" {
  name          = ...

  ...
  entry_point           = "helloGET"

  environment_variables = {
    DB_NAME = "test"
    DB_USER = google_sql_user.default.name
    DB_PASSWORD = random_id.user-password.hex
    DB_HOST = google_sql_database_instance.master.connection_name
  }
}
```

> You can notice the lack of a password definition and relation naming with the database, that information is provided by the terraform resources itself.

Rewrite our function into `code/index.js` file.

```javascript
const { Sequelize, Model, DataTypes } = require('sequelize');

const DB_NAME = process.env.DB_NAME;
const DB_USER = process.env.DB_USER;
const DB_PASSWORD = process.env.DB_PASSWORD;
const DB_HOST = process.env.DB_HOST;

const sequelize = new Sequelize(DB_NAME, DB_USER, DB_PASSWORD, {
  dialect: 'postgres',
  host: `/cloudsql/${DB_HOST}`,
  timestamps: false,
  dialectOptions: {
    socketPath: `/cloudsql/${DB_HOST}`,
  },
});
sequelize.sync().catch((err) => console.error(err));

class User extends Model {}

User.init({
  username: DataTypes.STRING,
  count: DataTypes.INTEGER,
}, { sequelize, modelName: 'user' });

/**
 * HTTP Cloud Function.
 *
 * @param {Object} req Cloud Function request context.
 *                     More info: https://expressjs.com/en/api.html#req
 * @param {Object} res Cloud Function response context.
 *                     More info: https://expressjs.com/en/api.html#res
 */
exports.helloGET = async (req, res) => {
  try {
    let lastUser;
    lastUser = await User.findOne({ where: { username: 'last' } });
    if (lastUser === null) {
      lastUser = await User.build({ username: 'last', count: 0 });
    }

    lastUser.count =  lastUser.count + 1;
    await lastUser.save();

    res.status(200).send(`Hello visitor: ${lastUser.count}`);
  } catch (err) {
    console.log(err);
    res.status(500).send(err.message);
  }
};
```

Deploy changes.

```shell
terraform apply --auto-approve
```

Lets list all the resources we have.

```shell
terraform state list
```

Lets inspect our function.

```shell
terraform state show '"google_cloudfunctions_function.function'
```

---

[Next Step - Improvements and clean up](./4-improvements-and-clean-up.md)