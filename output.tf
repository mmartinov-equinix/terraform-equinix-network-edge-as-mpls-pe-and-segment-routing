
output "equinix_network_device_ip_addresses" {
    description = "List of Network device SSH IP Addresses."
    value       = ["${equinix_network_device.c8kv-router.*.ssh_ip_address}"]
    }

