Readme
# Equinix Network Edge as MPLS PE router (and Segment Routing TE)

Equinix Network Edge offers virtual networking services. In this specific case, we’re using the Cisco 8000v as an MPLS PE router. While this represents just one way to utilize Network Edge devices, I’ll focus on demonstrating MPLS/Segment Routing configurations. Keep in mind that in a production environment, interconnection with an existing MPLS Backbone would be necessary, and the configurations would be similar. This scenario is valuable for extending customer VRFs across the cloud edge, allowing for effective segregation between different customers.

<img width="468" alt="image" src="https://github.com/mmartinov-equinix/terraform-equinix-network-edge-as-mpls-pe-and-segment-routing/assets/132877286/319d4cf3-f7a3-4fbb-aea1-9972218a9140">

Our ultimate objective is to establish infrastructure and configurations using a single command. We employ Segment Routing TE tunnels to illustrate how traffic between R1 and R3 can be directed along a preferred non-optimal path. Consequently, VRF communication will also follow this same route.

### Disclaimer: 
   * This configuration is experimental, designed for testing MPLS and SR capabilities in Equinix Network Edge with Cisco 8000v.
   * It serves as an example config and may require adjustments for specific networks.
   * Keep in mind that creating this setup will incur costs. If you prefer to test for free, explore Equinix Network Edge Free Tier, which allows only 2 Network Edge devices. You’ll need to adjust this code accordingly.
   * While this repository simplifies infrastructure creation and device configuration, it may not align with production workflows.

### Requirements:
   * Terraform up and running (Installation how to -> https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
      * For more about Equinix Terraform Registry (https://registry.terraform.io/providers/equinix/equinix/latest/docs)
   * Python3 up and running (https://www.python.org/downloads/)
   * Netmiko Python module to configure Cisco Devices. (https://pypi.org/project/netmiko/)
   * Fabric Portal User (How to create one -> https://docs.equinix.com/en-us/Content/Interconnection/Fabric/getting-started/Fabric-New-user-creation.htm)
   * For Terraform authentication use Equinix Fabric Client ID and Client Secret (ho to create -> https://developer.equinix.com/dev-docs/fabric/getting-started/getting-access-token)
   * Modify “terraform.tfvars” according to your values
   * Modify SSH username and SSH Key location in Python script "router-command-run.py".

### How to Deploy:
```
terraform init
terraform apply
```

### How to check:
   * Use Equinix Fabric GUI or Terraform outputs to monitor all components status.
   * Cisco 8000v configuration status checks:
      * Status check: for R1 & R3
        ```
         * show isis neighbors                                                   # Check and ensure ISIS neighbors are up and running
         * show ip bgp vpnv4 all summary                                         # Check and ensure MPBGP neighbors are up and running
         * show segment-routing traffic-eng policy all                           # Check and ensure SR Policy status
         * show segment-routing traffic-eng policy all color 10 detail           # Check and ensure SR Policy status and Tunnel id
         * show ip route                                                         # Verify next hop is same Tunnel ID to desination 
         * traceroute 10.0.0.3                                                   # traceroute the path to verify it is using SRTE path (for R3 desr IP is 10.0.0.1)
         * ping vrf VRF_A 10.2.0.3                                               # Ping to verify desination VRF is reachable via SRTE path (for R3 desr IP is 10.2.0.1)
        ```
      * Status check: for R2
        ```
         * show isis neighbors                                                   # Check and ensure ISIS neighbors are up and running
        ```


### Destroy Infrastructure:
```
terraform destroy
```
