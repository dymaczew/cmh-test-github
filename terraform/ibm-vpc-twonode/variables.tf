variable "region" {
  type = "string"
  default = "us-south"
}

variable "public_ssh_key" {
  type = "string"
}

variable "image_id" {
  type = "string"
  default = "r014-e0039ab2-fcc8-11e9-8a36-6ffb6501dd33"
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

