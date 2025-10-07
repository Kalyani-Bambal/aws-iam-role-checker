provider "aws" {
  region = var.region
}

data "aws_iam_role" "roles" {
  for_each = toset(var.role_names)
  name     = each.value
}

output "validated_roles" {
  value = [for k, v in data.aws_iam_role.roles : v.name]
}
