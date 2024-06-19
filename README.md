Readme
# Equinix Network Edge as MPLS PE router (and Segment Routing TE)

Equinix Network Edge provides virtual networking services, that we picket here Cisco 8000v to be used as MPLS PE router. This is just one model of consuming Network Edge devices, in which here I will show MPLS/Segment Routing configurations. In this example there is not any interconnection to existing MPLS Backbone, but of course it will be needed in production scenario, and configurations will be the similar. This scenario is useful to extend customer VRFs throughout the edge of cloud, and thanks to multiple VRFs which may help customers to be segregated from each other.

<img width="468" alt="image" src="https://github.com/mmartinov-equinix/terraform-equinix-network-edge-as-mpls-pe-and-segment-routing/assets/132877286/319d4cf3-f7a3-4fbb-aea1-9972218a9140">

End goal is to create infrastructure and configurations with single command. Segment Routing TE tunnels used to demonstrate how traffic is traffic between R1 and R3 is used to steer to use preferred non-optimal path. Hence, VRF communication also will follow the same path!

### Disclaimer: 
   * This is an Experimental practice, and it is created for testing MPLS and SR capabilities in Equinix Network Edge with Cisco 8000v.
   * It is an example config and may need to be adjusted for each network.
   * To create will cost you. If you still need want to test for free, check for Equinix Network Edge Free Tier, which is limited with only 2 Network Edge devices, so you will need to shrink/adjust this code.
   * This repo may help you to create infrastructure and configure devices on single command, but this may not fit into production workflows.

### Requirements:
   * Terraform up and running (Installation how to -> https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
      * For more about Equinix Terraform Registry (https://registry.terraform.io/providers/equinix/equinix/latest/docs)
   * Python3 up and running (https://www.python.org/downloads/)
   * Netmiko Python module to configure Cisco Devices. (https://pypi.org/project/netmiko/)
   * Fabric Portal User (How to create one -> https://docs.equinix.com/en-us/Content/Interconnection/Fabric/getting-started/Fabric-New-user-creation.htm)
   * For Terraform authentication use Equinix Fabric Client ID and Client Secret (ho to create -> https://developer.equinix.com/dev-docs/fabric/getting-started/getting-access-token)
   * Modify “terraform.tfvars” according to your values

### How to Deploy:
```
terraform init
terraform apply
```

### How to check:
   * Use Equinix Fabric GUI or Terraform outputs to monitor all components status.
   * Cisco 8000v configuration status checks:
      * Status check: R1 & R3
        ```
         * show isis neighbors                                                   # Check and ensure ISIS neighbors are up and running
         * show ip bgp vpnv4 all summary                                         # Check and ensure MPBGP neighbors are up and running
         * show segment-routing traffic-eng policy all                           # Check and ensure SR Policy status
         * show segment-routing traffic-eng policy all color 10 detail           # Check and ensure SR Policy status and Tunnel id
         * show ip route                                                         # Verify next hop is same Tunnel ID to desination 
         * traceroute 10.0.0.3                                                   # traceroute the path to verify it is using SRTE path (for R3 desr IP is 10.0.0.1)
         * ping vrf VRF_A 10.2.0.3                                               # Ping to verify desination VRF is reachable via SRTE path (for R3 desr IP is 10.2.0.1)
        ```
      * Status check: R2
        ```
         * show isis neighbors                                                   # Check and ensure ISIS neighbors are up and running
        ```


### Destroy Infrastructure:
```
terraform destroy
```
