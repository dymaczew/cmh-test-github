provider "ibm" {
  region = "${var.region}"
}

resource "ibm_is_vpc" "test_vpc" {
  name = "test-vpc"
  tags    = ["${concat(var.tags, module.camtags.tagslist)}"]
}

resource "ibm_is_subnet" "test_subnet" {
  name            = "test-subnet"
  vpc             = "${ibm_is_vpc.test_vpc.id}"
  zone            = "${var.zone}"
  ipv4_cidr_block = "10.241.0.0/24"
}

resource "ibm_is_ssh_key" "test_sshkey" {
  name       = "test-ssh"
  public_key = "${var.public_ssh_key}"
}

## Web server VSI
resource "ibm_is_instance" "web-server" {
  name    = "web-server-vsi"
  image   = "${var.image_id}"
  profile = "${var.profile}"

  primary_network_interface {
    subnet = "${ibm_is_subnet.test_subnet.id}"
  }

  vpc     = "${ibm_is_vpc.test_vpc.id}"
  zone    = "${var.zone}"
  keys    = ["${ibm_is_ssh_key.test_sshkey.id}"]
  tags    = ["${concat(var.tags, module.camtags.tagslist)}"]
}

## Attach floating IP address to web server VSI
resource "ibm_is_floating_ip" "test_floatingip" {
  name   = "test-fip"
  target = "${ibm_is_instance.web-server.primary_network_interface.0.id}"
}

## DB server VSI with additional data volume
resource "ibm_is_instance" "db-server" {
  name    = "db-server-vsi"
  image   = "${var.image_id}"
  profile = "${var.profile}"

  primary_network_interface {
    subnet = "${ibm_is_subnet.test_subnet.id}"
  }

  vpc     = "${ibm_is_vpc.test_vpc.id}"
  volumes = ["${ibm_is_volume.test-volume.id}"]
  zone    = "${var.zone}"
  keys    = ["${ibm_is_ssh_key.test_sshkey.id}"]
  tags    = ["${concat(var.tags, module.camtags.tagslist)}"]
}

resource "ibm_is_volume" "test-volume" {
  name     = "test-volume"
  profile  = "custom"
  zone     = "${var.zone}"
  iops     = 1000
  capacity = 20
  tags    = ["${concat(var.tags, module.camtags.tagslist)}"]
}

module "camtags" {
  source  = "../Modules/camtags"
}