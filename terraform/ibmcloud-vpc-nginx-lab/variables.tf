variable "region" {
  type = string
  default = "us-south"
}

variable "ipv4_cidr_block" {
  type = string
  default = "10.240.0.0/24"
}

variable "image_id" {
  type = string
  default = "r006-13938c0a-89e4-4370-b59b-55cd1402562d"
}

variable "vpc" {
  type = string
  default = ""
}

variable "securitygroup" {
  type = string
  default = ""
}

variable "subnet" {
  type = string
  default = ""
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
}

variable "dte-dallas-sshkey" {
  type = string
  default = "r006-effcadbf-929d-4b3b-ae37-fb9c4faf97f4"
}
