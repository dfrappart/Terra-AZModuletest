#This module deploys managed with AZ
#Choose a fixed AZ target with the ManagedDisk variable or let the module distribute the VMs in the AZ automatically
# beware, for now, i did not find a function to round robin from 1 to 3, so if the AZ is not specified, the module will use a list to distribute the AZ with a mawx value to 12 count