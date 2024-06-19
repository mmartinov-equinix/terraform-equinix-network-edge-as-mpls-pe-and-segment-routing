
data "equinix_network_account" "metro" {
  name       = var.metro_name
  metro_code = var.metro_code
}

resource "equinix_network_device" "c8kv-router" {
  count           = var.router_count
  name            = "${var.router_name_prefix}-${count.index+1}"
  hostname        = "${var.router_name_prefix}-${count.index+1}"
  metro_code      = data.equinix_network_account.metro.metro_code
  type_code       = "C8000V"
  self_managed    = true
  byol            = true
  package_code    = "network-advantage"
  notifications   = var.notification_mail_list
  account_number  = data.equinix_network_account.metro.number
  version         = "17.14.01a"
  core_count      = 2
  term_length     = 1
  ssh_key {
    username = var.ssh_username   # assuming you already have uploaded SSH key in Equinix Fabric Portal
    key_name = var.ssh_keyname    # assuming you already have uploaded SSH key in Equinix Fabric Portal
  }

  # assuming you already have ACL created in Fabric portal.
  acl_template_id = var.acl_template_uuid 
}
