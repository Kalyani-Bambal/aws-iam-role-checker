variable "region" {
  description = "AWS region to run prechecks in"
  type        = string
}

variable "role_names" {
  description = "List of IAM role names to validate existence"
  type        = list(string)
}
