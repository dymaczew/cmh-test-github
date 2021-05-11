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
  default = "bx2-2x8"
}

variable "zone" {
  type = string
  default = "us-south-1"
}

variable "tags" {
  type = list(string)
  default = ["thinklab:2176"]
}

variable "prefix" {
  type = string
  default = "changeme"
}
