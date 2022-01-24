# tkg_onecloud
scripts to facilitate tkg deployment and management on Onecloud 

These scripts are meant to assist in deployming VMware TKG (m or s) in a onecloud vSphere v7 for tanzu template
This repo is focused on NSX ALB + vSphere with tanzu

# How to use

1 - edit values in "define_download_version_env" file 
2 - execute scripts as needed


# Subnets

192.168.110.0/24 - management network, used for ESXi management traffic, VC/NSX Mgr/NSX Edge/WCP management traffic

10.10.20.0/24 - storage network, used by ESXi hosts and TrueNAS NFS server

10.10.30.0/24 - vmotion network, used by the ESXi hots for VMotion

192.168.100.100-250 - DHCP pool for ESXi hosts during installation

192.168.120.0/24 - TKGI/TKGS: Edge TEP network, used by the NSX Edges for tunnel endpoint traffic, 192.168.120.1 gateway lives on VyOS. VLAN is 120.

192.168.130.0/24 - TKGI/TKGS: Host TEP network, used by the ESXi hosts for tunnel endpoint traffic. TKGm: K8s node network. 192.168.130.1 gateway lives on VyOS. 
VLAN is 130. 192.168.130.150-250 is the DHCP pool for K8s nodes and NSX ALB SEs.

192.168.210.0/24 - TKGI/TKGS: uplink network, provides egress from the T0 router to the VyOS, 192.168.210.1 gateway lives on VyOS. VLAN is 210.

192.168.220.0/23 - TKGS/TKGm: virtual service/load balancer network.  192.168.220.1 gateway lives on VyOS. VLAN is 220.

192.168.220.128-254 is the DHCP pool for NSX ALB virtual services.

10.40.14.0/24 - routable network between 192.168 network and internal PKS/Kubernetes networks. LB IP addresses come from this pool. Usually carved up into /27 networks.

172.31.0.0/24 - TKGI management network, used by Bosh, TKGI and Harbor VMs

172.15.0.0/16 - TKGI node network, used by PKS cluster nodes

172.16.0.0/16 - TKGI deployment network, used by Kubernetes pods/services running in PKS clusters


# Virtual Switches:

vSwitch0: This is a standard virtual switch on each host that is remnant of the initial ESXi installation. It is not in use after the hosts have been configured in VC. You can remove vmnic0 and reuse it for another uplink if needed.

DSwitch-MGMT: This is the management distributed virtual switch. The management (DSwitch-Management), vmotion (DSwitch-VMotion), storage (DSwitch-NFS), Kubernetes node VM (K8s-Workload, VLAN 130) and Kubernetes service (K8s-Frontend, VLAN 220) portgroups live on this vDS. The uplink in use is vmnic1.