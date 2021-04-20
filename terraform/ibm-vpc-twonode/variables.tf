variable "region" {
  type = "string"
  default = "us-south"
}

variable "public_ssh_key" {
  type = "string"
}

variable "image_id" {
  type = "string"
  default = "r006-09ff9db7-78cd-42b3-9e82-0729ed3a3360"
}

variable "profile" {
  type = "string"
  default = "bx2-2x8"
}

variable "zone" {
  type = "string"
  default = "us-south-1"
}

variable "tags" {
  type = list(string)
  default = ["tag1:test1", "tag2:test2"]
}

