output "found_roles" {
  value = [for r in data.aws_iam_role.required : r.name]
}
