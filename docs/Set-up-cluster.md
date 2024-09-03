# Setting Up Raspberry Pi 4 Kubernetes Cluster

This guide walks you through setting up a Kubernetes cluster on Raspberry Pi 4 devices.

## Requirements

- Raspberry Pi 4 Model B (x3 or more)
- SD cards for each Pi
- Ethernet cables
- Network switch or router

## Steps

### 1. Prepare the OS

1. Download the Raspberry Pi Imager and flash the 64-bit Raspberry Pi OS Lite (Bullseye) onto each SD card.
2. Enable SSH by creating an empty `ssh` file in the boot partition of each SD card.
3. Create a `userconf` file with the username and encrypted password.

### 2. Initial Setup

1. SSH into the Raspberry Pi and perform initial setup tasks such as adding the user to the sudo group and enabling console autologin.
2. Install Docker and Kubernetes components, including `cri-dockerd` for container runtime.

### 3. Initialize the Kubernetes Cluster

1. Create a configuration file (`kubeadm-config.yaml`) for your master node.
2. Run `kubeadm init` to initialize the control plane on your master node.
3. Set up networking for the cluster using Flannel.

### 4. Add Worker Nodes

1. Repeat the initial setup on each worker node.
2. Use the `kubeadm join` command to add worker nodes to the cluster.

### 5. Verify the Cluster

1. Check node status with `kubectl get nodes`.
2. Ensure all nodes are in `Ready` state.

For more detailed instructions, refer to the original setup guide or documentation.
