variable "client_id" {
  description = "Equinix Fabric portal Client ID. (for API Authentication)"
  type        = string
}

variable "client_secret" {
  description = "Equinix Fabric portal Client Secret. (for API Authentication)"
  type        = string
}

variable "metro_code" {
  description = "Equinix 2 letter Metro Code."
  type        = string
}

variable "metro_name" {
  description = "Billing account name in string format used to specify Billing account."
  type        = string
}

variable "router_count" {
  description = "Number of NE Routers to be created"
  type        = number
}

variable "router_name_prefix" {
  description = "Prefix to be used on router name in GUI and in hostname of device."
  type        = string
}

variable "ssh_username" {
  description = "Username used to SSH devices. SSH Key is assumed to be already in Equinix Fabric portal!"
  type        = string
}

variable "ssh_keyname" {
  description = "The name of SSH key used to SSH devices. SSH Key is assumed to be already in Equinix Fabric portal."
  type        = string
}

variable "notification_mail_list" {
  description = "List of mail addresses to be notified about these devices."
  type        = list
}

variable "acl_template_uuid" {
  description = "UUID of your ACLs in Equinix Fabric Portal! Assuming it is already created."
  type        = string
}

