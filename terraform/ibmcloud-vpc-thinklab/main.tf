provider "ibm" {
  region = "${var.region}"
}

resource "ibm_is_vpc" "test_vpc" {
  name    = join("-", [ "vpc", var.username ])
  tags    = "${concat(var.tags, module.camtags.tagslist)}"
}

resource "ibm_is_subnet" "test_subnet" {
  name    = join("-", [ "subnet", var.username ])
  vpc             = "${ibm_is_vpc.test_vpc.id}"
  zone            = "${var.zone}"
  ipv4_cidr_block = "10.240.0.0/18"
}

resource "ibm_is_ssh_key" "test_sshkey" {
  name    = join("-", [ "sshkey", var.username ])
  public_key = "${var.public_ssh_key}"
}

## Web server VSI
resource "ibm_is_instance" "web-server" {
  name    = join("-", ["web-server-vsi", var.username ])
  image   = "${var.image_id}"
  profile = "${var.profile}"

  primary_network_interface {
    subnet = "${ibm_is_subnet.test_subnet.id}"
  }

  vpc     = "${ibm_is_vpc.test_vpc.id}"
  zone    = "${var.zone}"
  keys    = ["${ibm_is_ssh_key.test_sshkey.id}"]
  tags    = "${concat(var.tags, module.camtags.tagslist, local.lifecycle_tags)}"

  lifecycle {
  ignore_changes = [
    tags
  ]
  }
}

## Attach floating IP address to web server VSI
resource "ibm_is_floating_ip" "test_floatingip" {
  name   = "test-fip"
  target = "${ibm_is_instance.web-server.primary_network_interface.0.id}"
}

## DB server VSI with additional data volume
resource "ibm_is_instance" "db-server" {
  name    = join("-", ["db-server-vsi", var.username ])
  image   = "${var.image_id}"
  profile = "${var.profile}"

  primary_network_interface {
    subnet = "${ibm_is_subnet.test_subnet.id}"
  }

  vpc     = "${ibm_is_vpc.test_vpc.id}"
  volumes = ["${ibm_is_volume.test-volume.id}"]
  zone    = "${var.zone}"
  keys    = ["${ibm_is_ssh_key.test_sshkey.id}"]
  tags    = "${concat(var.tags, module.camtags.tagslist, local.lifecycle_tags)}"

  lifecycle {
  ignore_changes = [
    tags
  ]
  }
}

resource "ibm_is_volume" "test-volume" {
  name     = join("-", ["volume", var.username ])
  profile  = "custom"
  zone     = "${var.zone}"
  iops     = 1000
  capacity = 20
  tags    = "${concat(var.tags, module.camtags.tagslist)}"
}

module "camtags" {
  source  = "../Modules/camtags"
}
