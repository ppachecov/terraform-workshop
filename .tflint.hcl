plugin "google" {
    enabled = true
    version = "0.13.0"
    source  = "github.com/terraform-linters/tflint-ruleset-google"
}

rule "terraform_module_version" {
  enabled = false
  exact = false # default
}
