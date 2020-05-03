# ---------------------------------------------------------------------------------------------------------------------
# Define provider for terraform and Shared Credentials file
# ---------------------------------------------------------------------------------------------------------------------

# Configure the AWS Provider
provider "aws" {
  version = "~> 2.0"
  region  = "eu-central-1"
  shared_credentials_file = "/home/User/.aws/credentials"
}