provider "ibm" {
  region = "${var.region}"
}

resource "random_id" "default" {
  byte_length = "4"
}

resource "ibm_is_vpc" "test_vpc" {
  name    = "${var.prefix}-${random_id.default.hex}-vpc"
  tags    = "${concat(var.tags, module.camtags.tagslist)}"
}

resource "ibm_is_subnet" "test_subnet" {
  name    = "${var.prefix}-${random_id.default.hex}-subnet"
  vpc             = "${ibm_is_vpc.test_vpc.id}"
  zone            = "${var.zone}"
  ipv4_cidr_block = "10.240.0.0/24"
}

resource "ibm_is_ssh_key" "test_sshkey" {
  name    = "${var.prefix}-${random_id.default.hex}-sshkey"
  public_key = "${var.public_ssh_key}"
}

## Web server VSI
resource "ibm_is_instance" "web-server" {
  name    = "${var.prefix}-${random_id.default.hex}-web-server-vsi"
  image   = "${var.image_id}"
  profile = "${var.profile}"
  user_data = file("userdata.tpl")

  primary_network_interface {
    subnet = "${ibm_is_subnet.test_subnet.id}"
    security_groups = ["${ibm_is_security_group.webapptier-securitygroup.id}"]
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
  name   = "${var.prefix}-${random_id.default.hex}-fip"
  target = "${ibm_is_instance.web-server.primary_network_interface.0.id}"
}

## DB server VSI with additional data volume
resource "ibm_is_instance" "db-server" {
  name    = "${var.prefix}-${random_id.default.hex}-db-server-vsi"
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
  name     = "${var.prefix}-${random_id.default.hex}-volume"
  profile  = "custom"
  zone     = "${var.zone}"
  iops     = 1000
  capacity = 20
  tags    = "${concat(var.tags, module.camtags.tagslist, local.lifecycle_tags)}"

  lifecycle {
  ignore_changes = [
    tags
  ]
  }
}

module "camtags" {
  source  = "../Modules/camtags"
}
