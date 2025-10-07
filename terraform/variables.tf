variable "role_names" {
  type = list(string)
}

variable "region" {
  type    = string
  default = "us-east-1"
}

terraform {
  required_version = ">= 1.0"
}
