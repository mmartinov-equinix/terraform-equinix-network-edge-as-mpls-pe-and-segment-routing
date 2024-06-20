# MM - June 2024

from netmiko import Netmiko
from os import popen
from time import sleep

# Establishing connection to each device and configure the content in config file/s.
def connect_device(device, config_file):
    # Add your SSH username into "username". 
    # Add absolute path of your SSH key into "key_file".
    host = {"ip":device.strip(), "username":"your_username", "device_type":"cisco_ios", "use_keys":True, "key_file":"absolute_path_of_ssh_key", "disable_sha2_fix": True}

    try:
        net_connect = Netmiko(**host)
        net_connect.enable()
        output = net_connect.send_config_from_file(config_file)
        output += net_connect.save_config()
        return output
    except Exception as ex:
        print(f"{device} connection FAILED! -  Error message: ", ex)

# Sometimes terraform output is taking time and causing errors, that is why adding delay to overcome it.
sleep(20)

# Lists the devices created via Terraform
devices = popen(f"terraform output equinix_network_device_ip_addresses").read()

# List of the configuration files, in order of devices!
# In case number is different than 3, please specify config file for each device accordingly!
config_files = ["r1_config_sr_test.txt", "r2_config_sr_test.txt", "r3_config_sr_test.txt"]

# Iterating through each device and config file, to push config into this device.
# eval(devices)[0]    is to parse from string to list and pull only the interesting item in the list.
for device, config_file in zip(eval(devices)[0], config_files):
    print("Configuring device: ", device)
    connect_device(device, config_file)



