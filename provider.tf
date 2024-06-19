terraform {
  required_providers {
    equinix = {
      source = "equinix/equinix"
      version = "1.37.0"
    }
  }
}

provider "equinix" {
  client_id     = var.client_id
  client_secret = var.client_secret
}
