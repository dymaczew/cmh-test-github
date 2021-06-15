variable "region" {
  type = string
  default = "us-south"
}

variable "public_ssh_key" {
  type = string
}

variable "image_id" {
  type = string
  default = "r006-13938c0a-89e4-4370-b59b-55cd1402562d"
}

variable "profile" {
  type = string
  default = "cx2-2x4"
}

variable "zone" {
  type = string
  default = "us-south-1"
}

variable "tags" {
  type = list(string)
  default = ["ibmdte:inframgmtlab"]
}

variable "prefix" {
  type = string
  default = "changeme"
}

variable "resource_group" {
  type = string
  default = "075cb81ce7b944ad8a3e8f8cc46ccebb"
