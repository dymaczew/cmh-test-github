provider "ibm" {
  region = var.region
}

resource "random_id" "default" {
  byte_length = "4"
}

locals {
  prefix = lower(var.prefix)
}


## Web server VSI
resource "ibm_is_instance" "web-server" {
  name    = "${local.prefix}-${random_id.default.hex}-web-server-vsi"
  image   = "${var.image_id}"
  profile = "${var.profile}"
  user_data = file("userdata.tpl")
  resource_group = var.resource_group 

  primary_network_interface {
    subnet = "${var.subnet}"
    security_groups = ["${var.securitygroup}"]
  }

  vpc     = "${var.vpcid}"
  zone    = "${var.zone}"
  keys    = [var.dte-dallas-sshkey]
  tags    = "${concat(var.tags, module.camtags.tagslist, local.lifecycle_tags)}"

  lifecycle {
  ignore_changes = [
    tags
  ]
  }
}

## Attach floating IP address to web server VSI
resource "ibm_is_floating_ip" "test_floatingip" {
  name   = "${local.prefix}-${random_id.default.hex}-fip"
  target = "${ibm_is_instance.web-server.primary_network_interface.0.id}"
  resource_group = "${var.resource_group}" 
}

module "camtags" {
  source  = "../Modules/camtags"
}
