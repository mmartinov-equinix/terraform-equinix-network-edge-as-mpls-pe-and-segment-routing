# Device Links to interconnect NE devices to each others

resource "equinix_network_device_link" "r1-to-r2" {
  name   = "r1-to-r2"

  device {
    id           = equinix_network_device.c8kv-router.0.uuid
    interface_id = 5
  }
  device {
    id           = equinix_network_device.c8kv-router.1.uuid
    interface_id = 6
  }
  metro_link {
    account_number  = data.equinix_network_account.metro.number
    metro_code = var.metro_code
    throughput      = "50"
    throughput_unit = "Mbps"
  }
}

resource "equinix_network_device_link" "r2-to-r3" {
  name   = "r2-to-r3"

  device {
    id           = equinix_network_device.c8kv-router.1.uuid
    interface_id = 5
  }
  device {
    id           = equinix_network_device.c8kv-router.2.uuid
    interface_id = 6
  }
  metro_link {
    account_number  = data.equinix_network_account.metro.number
    metro_code = var.metro_code
    throughput      = "50"
    throughput_unit = "Mbps"
  }
}

resource "equinix_network_device_link" "r3-to-r1" {
  name   = "r3-to-r1"

  device {
    id           = equinix_network_device.c8kv-router.2.uuid
    interface_id = 5
  }
  device {
    id           = equinix_network_device.c8kv-router.0.uuid
    interface_id = 6
  }
  metro_link {
    account_number  = data.equinix_network_account.metro.number
    metro_code = var.metro_code
    throughput      = "50"
    throughput_unit = "Mbps"
  }
}

