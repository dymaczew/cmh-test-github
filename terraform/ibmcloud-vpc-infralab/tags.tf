locals {
  crtime = timestamp()
  createdDate = formatdate( "DD MMM YYYY hh-mm ZZZ", local.crtime )
  validThrough = formatdate( "DD MMM YYYY hh-mm ZZZ", timeadd(local.crtime, "2h"))
  lifecycle_tags = [ "createDate:${local.createdDate}", "validThrough:${local.validThrough}"]

  # Usage - tags = merge(local.common_tags) in resources.
}
