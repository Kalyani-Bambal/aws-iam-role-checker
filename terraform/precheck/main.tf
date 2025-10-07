provider "aws" {
  region = var.region
  # credentials come from env (AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_SESSION_TOKEN)
}

# Try to resolve each required role. If any role does not exist, terraform plan will error.
data "aws_iam_role" "required" {
  for_each = toset(var.role_names)
  name     = iam.key
}
