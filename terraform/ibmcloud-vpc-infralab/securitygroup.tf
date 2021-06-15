#---------------------------------------------------------
# Create Webapptier Security Group & Rules
#---------------------------------------------------------
resource "ibm_is_security_group" "webapptier-securitygroup" {
  name = "${var.prefix}-${random_id.default.hex}-webapptier-securitygroup"
  vpc  = "${ibm_is_vpc.test_vpc.id}"
}

resource "ibm_is_security_group_rule" "webapptier-securitygroup-rule1" {
  group      = "${ibm_is_security_group.webapptier-securitygroup.id}"
  direction  = "inbound"
  ip_version = "ipv4"
  remote     = "0.0.0.0/0"

  tcp { 
    port_min = 22
    port_max = 22
  }

  depends_on = [ibm_is_security_group.webapptier-securitygroup]
}

resource "ibm_is_security_group_rule" "webapptier-securitygroup-rule2" {
  group      = "${ibm_is_security_group.webapptier-securitygroup.id}"
  direction  = "inbound"
  ip_version = "ipv4"
  remote     = "0.0.0.0/0"

  tcp {
    port_min = 80
    port_max = 80
  }
  depends_on = [ibm_is_security_group.webapptier-securitygroup]
}

resource "ibm_is_security_group_rule" "webapptier-securitygroup-rule3" {
  group      = "${ibm_is_security_group.webapptier-securitygroup.id}"
  direction  = "outbound"
  ip_version = "ipv4"
  remote     = "0.0.0.0/0"

  depends_on = [ibm_is_security_group.webapptier-securitygroup]
}
