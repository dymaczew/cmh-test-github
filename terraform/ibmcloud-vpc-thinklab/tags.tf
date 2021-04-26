locals {
  createdDate = formatdate( "DD MMM YYYY hh:mm ZZZ", timestamp() )
  validThrough = timeadd(local.createdDate, "2h")
  lifecycle_tags = [ "createDate:${local.createdDate}", "validThrough:${local.validThrough}"]

  # Usage - tags = merge(local.common_tags) in resources.
}