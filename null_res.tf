
# Triggering Python code after NE devices are deployed.
resource "null_resource" "run_python" {

  provisioner "local-exec" {
    command = "python3 router-command-run.py"
  }

  depends_on = [
    equinix_network_device.c8kv-router
  ]

}

