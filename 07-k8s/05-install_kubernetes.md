# Install kubernetes 1.30 on ubuntu 22.04

## Set ip address and VPN :)

## Step 1: Configure Hostnames and Update `/etc/hosts`

### Set the Hostname

First, set the hostname on each node as follows:

- On k8s1:

  ```bash
  hostnamectl set-hostname k8s1
  ```

- On k8s2:

  ```bash
  hostnamectl set-hostname k8s2
  ```

- On k8s3:

  ```bash
  hostnamectl set-hostname k8s3
  ```

#### Update the `/etc/hosts` File

Use the `cat` command with a here-document to append the new host entries directly to `/etc/hosts`. This can be done with root privileges using `sudo`:

```bash
cat >> /etc/hosts <<EOF
172.16.0.10 k8s1
172.16.0.11 k8s2
172.16.0.12 k8s3
EOF
```

Continuing with your Kubernetes installation guide, the second step will be disabling swap on all nodes. This is an important prerequisite for Kubernetes as it requires swap to be turned off to function properly.

### Step 2: Disable Swap on All Nodes

Kubernetes requires that swap is disabled on all nodes to ensure consistent performance and resource availability. The swap needs to be disabled before initiating Kubernetes.

#### Disable Swap

Perform this operation on each node to disable swap immediately:

```bash
sudo swapoff -a
```

This command disables swap immediately. However, to make this change permanent, so that swap remains disabled even after a reboot, you need to edit the `/etc/fstab` file.

#### Make the Swap Disable Permanent

1. Open the `/etc/fstab` file in a text editor. You can use `vim` or any other editor:

   ```bash
   sudo vim /etc/fstab
   ```

2. Comment out the line that refers to swap. This line typically contains the word 'swap'. You can comment it out by adding a `#` at the beginning of the line. It might look something like this:
```bash
swapoff -a

sed -i '/swap/s/^\//\#\//g' /etc/fstab
```

   Save the file and exit the editor.

#### Verify Swap Is Disabled

After you have disabled and removed swap from `/etc/fstab`, you can ensure it is turned off by checking with the following command:

```bash
free -h
```

Look under the swap section; it should show 0B indicating that swap is not in use.

### Step 3: Install `containerd.io` Runtime on All Servers

`containerd.io` is a lightweight container runtime that is used by Docker and can also be used independently by Kubernetes. To install `containerd.io`, we will set up the Docker repository and install the necessary packages.

#### Prerequisites

- Ensure each node has internet access.
- Confirm that you have sudo or root privileges on each node.

#### Installation Instructions

1. **Prepare the System and Add Docker's Official GPG Key**:
   Begin by updating your package manager and installing prerequisites that allow your system to use repositories over HTTPS:

   ```bash
   sudo apt-get update
   sudo apt-get install ca-certificates curl
   sudo install -m 0755 -d /etc/apt/keyrings
   sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
   sudo chmod a+r /etc/apt/keyrings/docker.asc
   ```

2. **Add the Docker Repository**:
   Add Docker’s official repository to your list of repositories to ensure you are installing the latest version of `containerd.io`:

   ```bash
   echo \
   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
   $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
   sudo apt-get update
   ```

3. **Install Docker and `containerd.io`**:
   Now install Docker Engine, CLI, `containerd.io`, and other Docker components:

   ```bash
   sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
   ```

#### Post-Installation Steps

- **Verify Installation**:
  Ensure that `containerd` is installed and running correctly:

  ```bash
  containerd --version
  ```

This step ensures that each node in your Kubernetes cluster is equipped with `containerd.io`, setting a stable foundation for deploying and managing containerized applications.


### Step 4: Configure `containerd`

After installing `containerd.io`, it is important to set up the configuration file to ensure that it is optimized for your Kubernetes setup. This involves generating a default configuration file and placing it in the appropriate directory.

#### Save `containerd` Configuration

To create and save the default `containerd` configuration file, follow these steps:

1. **Generate the Default Configuration File**:
   Run the following command to generate the default `containerd` configuration and save it to the standard configuration directory:

   ```bash
   sudo containerd config default > /etc/containerd/config.toml
   ```

#### Post-Configuration Steps

- **Restart `containerd`**:
  After saving and modifying the configuration file, restart the `containerd` service to apply the changes:

  ```bash
  sudo systemctl restart containerd
  ```

- **Verify the Configuration**:
  Ensure that `containerd` is using the new configuration file and is running correctly:

  ```bash
  sudo systemctl status containerd
  ```

### Step 5: Update `containerd` Configuration to Use Systemd for Cgroup Management

Kubernetes recommends using `systemd` for cgroup management to ensure consistent and reliable resource handling. This step involves editing the `containerd` configuration file to enable `SystemdCgroup`.

#### Modify the `containerd` Configuration

1. **Open the Configuration File**:
   Edit the `/etc/containerd/config.toml` configuration file with a text editor. Here, we'll use `vim`, but you can use any editor available on your system:

   ```bash
   sudo vim /etc/containerd/config.toml
   ```

2. **Change Cgroup Management to Systemd**:
   Locate the line that reads `SystemdCgroup = false` under the `[plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options]` section. Change `false` to `true`. It should look like this:

   ```bash
   sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
   systemctl restart containerd
   systemctl enable containerd
   ```

   ```toml
   SystemdCgroup = true
   ```

   If the line doesn't exist, you may need to add it under the appropriate section as shown above.

3. **Save and Close the File**:
   After making the changes, save the file and exit the editor.

#### Apply the Configuration Changes

- **Restart `containerd`**:
  To apply the changes, restart the `containerd` service:

  ```bash
  sudo systemctl restart containerd
  ```

- **Verify the Changes**:
  Check that `containerd` has restarted successfully and is running with the new configuration:

  ```bash
  sudo systemctl status containerd
  ```

Continuing with your Kubernetes installation guide, the next step involves preparing the Linux kernel for Kubernetes networking by loading specific modules. These modules are crucial for network policies and overlay networks, which are essential for Kubernetes.

### Step 6: Load Required Kernel Modules

Kubernetes requires certain kernel modules to be loaded for its networking components to function properly. Specifically, `br_netfilter` and `overlay` modules are needed to manage network traffic and to support network overlays respectively.

#### Load Kernel Modules

1. **Load the Modules**:
   Use the `modprobe` command to load the required kernel modules. This command should be run on each node:

   ```bash
   sudo modprobe br_netfilter overlay
   ```

2. **Ensure the Modules Are Loaded Automatically at Boot**:
   To ensure these modules are loaded automatically at system startup, add them to the `/etc/modules-load.d/modules.conf` file:

   ```bash
   echo 'br_netfilter' | sudo tee -a /etc/modules-load.d/modules.conf
   echo 'overlay' | sudo tee -a /etc/modules-load.d/modules.conf
   ```

#### Verify the Modules Are Loaded

After loading the modules, it's good practice to check that they are indeed active. You can do this with the `lsmod` command:

- **Check `overlay` Module**:

  ```bash
  lsmod | grep overlay
  ```

- **Check `br_netfilter` Module**:

  ```bash
  lsmod | grep br_netfilter
  ```

If the commands above return output, it confirms that the respective modules are loaded. If there's no output, it may indicate that the module is not loaded or not available in your kernel.

### Step 7: Configure Kernel Parameters for Networking

For Kubernetes to manage and route network traffic effectively, certain kernel parameters need to be configured. One of these parameters is `net.ipv4.ip_forward`, which allows the Linux kernel to forward IP packets between all the network interfaces on the machine. This is essential for proper network operations in a Kubernetes cluster.

#### Edit sysctl Configuration

1. **Open the sysctl Configuration File**:
   Use `vim` or any other text editor to edit the `/etc/sysctl.conf` file. This file contains kernel parameters that are loaded at boot time:

   ```bash
   sudo vim /etc/sysctl.conf
   ```

2. **Add the IP Forwarding Parameter**:
   At the end of the file, add the following line to enable IP packet forwarding:

   ```bash
   net.ipv4.ip_forward=1
   ```

3. **Save and Close the File**:
   After adding the parameter, save your changes and exit the editor.

#### Apply the Configuration Changes

After editing the configuration file, apply the changes to make them effective immediately:

- **Reload sysctl Settings**:

  ```bash
  sudo sysctl -p
  ```

- **Apply System-Wide Changes**:

  ```bash
  sudo sysctl --system
  ```

These commands reload the sysctl configuration from `/etc/sysctl.conf` and other system configuration files, applying the changes immediately without requiring a reboot.

#### Verify the Changes

To confirm that the IP forwarding parameter is set correctly, you can use the `sysclt` command to check its current value:

```bash
sysctl net.ipv4.ip_forward
```

The output should show `net.ipv4.ip_forward = 1`, indicating that IP forwarding is enabled.

### Step 8: Install Essential System Packages

Before proceeding with the Kubernetes components installation, it's important to ensure your system has all the necessary packages installed. These packages are critical for the secure and efficient operation of Kubernetes.

#### Install Required Packages

Execute the following command on each node to install the required packages:

```bash
sudo apt-get update
sudo apt-get install ca-certificates curl apt-transport-https conntrack -y
```

- **`ca-certificates`**: This package is crucial for security and provides a set of CA certificates commonly used to verify the identity of remote servers via SSL/TLS.
- **`curl`**: Used for transferring data with URLs. It's often used in scripts and system operations.
- **`apt-transport-https`**: Allows the package manager to transfer files and data over HTTPS, ensuring secure communication with repositories.
- **`conntrack`**: Used for tracking network connections as part of the netfilter project in the Linux kernel, which is important for network management in Kubernetes.

### Step 9: Install Additional System Packages for Kubernetes v1.30

As you prepare your system for Kubernetes v1.30, certain packages are required to ensure the system can securely connect to and manage repositories and packages. This step involves installing these necessary packages.

#### Update Package Lists

Start by updating your system's package list to ensure you have the latest information on available packages:

```bash
sudo apt-get update
```

#### Install Necessary Packages

Proceed to install the necessary packages. Note that `apt-transport-https` might be a dummy package in newer versions of Ubuntu, so installation might indicate that it's not necessary:

```bash
# Install essential packages for Kubernetes setup
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
```

Download the public signing key for the Kubernetes package repositories. The same signing key is used for all repositories so you can disregard the version in the URL:

### Step 10: Add the Kubernetes Package Repository Signing Key

Doc is here: https://v1-30.docs.kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

Before installing Kubernetes components, it is critical to verify the authenticity of the packages using a trusted signing key. This step involves downloading and installing the public signing key for Kubernetes package repositories.

1. **Prepare the Keyring Directory**:
   Ensure that the `/etc/apt/keyrings` directory exists, as this is where the signing key will be stored. If it doesn't exist, create it with the following command:

   ```bash
   sudo mkdir -p -m 755 /etc/apt/keyrings
   ```

2. **Download and Install the Signing Key**:
   Use `curl` to download the signing key from Kubernetes' official package source and add it to your system's trusted keys using `gpg`:

   ```bash
   curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
   ```

This command fetches the GPG key and saves it in a dearmored format in the appropriate directory, preparing your system to securely install verified Kubernetes packages.


Here's the formatted step for adding the Kubernetes apt repository and installing Kubernetes components such as `kubelet`, `kubeadm`, and `kubectl`, suitable for Kubernetes version 1.30:

---

### Step 11: Add the Kubernetes apt Repository and Install Components

To install Kubernetes components like `kubelet`, `kubeadm`, and `kubectl`, you must first add the appropriate Kubernetes apt repository that contains packages specifically for Kubernetes 1.30. Please adjust the URL if you are using a different minor version of Kubernetes.

1. **Add the Kubernetes Repository**:
   Configure your system to use the official Kubernetes apt repository for version 1.30:

   ```bash
   # This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
   echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
   ```

2. **Update the apt Package Index**:
   Update the apt package index to include the new repository:

   ```bash
   sudo apt-get update
   ```

3. **Check Available Versions**:
   Optionally, check the available versions of `kubeadm` to confirm the correct version is available:

   ```bash
   sudo apt-cache policy kubeadm
   ```

4. **Install Kubernetes Components**:
   Install `kubelet`, `kubeadm`, and `kubectl`, and ensure their versions are pinned to avoid unintentional upgrades:

   ```bash
   sudo apt-get install -y kubelet kubeadm kubectl
   sudo apt-mark hold kubelet kubeadm kubectl
   ```

5. **Verify Installation**:
   After installation, verify that the installed versions of the components are correct:

   ```bash
   kubectl version
   kubeadm version
   kubelet --version
   ```

and then check kubelet # its not active and normal don't worry

```bash
systemctl status kubelet.service
```

(Optional) Enable the kubelet service before running kubeadm:

sudo systemctl enable --now kubelet

### Step 12: Initialize the Kubernetes Cluster (Calico and flannel)

To start your Kubernetes cluster, you need to run the `kubeadm init` command on your master node. This command initializes the cluster with a specific configuration.

1. **Run the Initialization Command**:
   Execute the `kubeadm init` command with parameters to set the API server's advertise address and the pod network CIDR. This setup is crucial for the correct operation of network components in Kubernetes:

   Flannel (a network add-on) typically uses the range `10.244.0.0/16` for its pod network.

```bash
kubeadm init --control-plane-endpoint 192.168.178.11 --apiserver-advertise-address=192.168.178.11 --pod-network-cidr 10.244.0.0/16
```

   Calico (a network add-on) typically uses the range `192.168.0.0/16` for its pod network.

```bash
kubeadm init --control-plane-endpoint 192.168.178.11 --apiserver-advertise-address=192.168.178.11 --pod-network-cidr=192.168.0.0/16
```

   - `--apiserver-advertise-address 172.16.0.10`: Specifies the IP address the API server uses to advertise to members of the cluster.
   - `--pod-network-cidr 10.244.0.0/16`: Specifies the range of IP addresses for the pod network. The example uses the range that Flannel (a network add-on) typically uses.
   - `--pod-network-cidr=192.168.0.0/16` : Specifies the range of IP addresses for the pod network. The example uses the range that Calico (a network add-on) typically uses.

2. **Save the Output**:
   The output of the `kubeadm init` command includes a `kubeadm join` command, which you will use to connect your worker nodes to the cluster. It is crucial to save this output for future reference.

```bash
Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 172.16.0.10:6443 --token si409n.4t84qt3y60vlfu7r \
	--discovery-token-ca-cert-hash sha256:afb455a1be808d2a5687a71d7ca92db4118349736699e59693b66395826a5e48
```

### Step 13: Install Flannel as the Network Add-On

Once your Kubernetes cluster is initialized, the next step is to install a network add-on to manage the networking between the pods across all nodes. Flannel is a popular choice due to its simplicity and effectiveness.

**Install Flannel**:
   Run the following command on your master node to deploy Flannel to your cluster:

   ```bash
   kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml
   ```

**Install Calico**:
   Run the following command on your master node to deploy Calico to your cluster:

   ```bash
   kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.29.0/manifests/tigera-operator.yaml
   kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.29.0/manifests/custom-resources.yaml
   ```

   This command downloads and applies the Flannel configuration from its official GitHub repository. It sets up Flannel to manage the pod network across your cluster.

1. **Verify the Installation**:
   After applying the Flannel configuration, check the status of the Flannel pods to ensure they are running correctly:

   ```bash
   kubectl get pods --all-namespaces
   ```

   Look for the Flannel pods and ensure their status is `Running`.

kubernetes addons # search in the internet
https://kubernetes.io/docs/concepts/cluster-administration/addons/

### Step 14: Set Up Bash Autocompletion for kubectl and kubeadm

Bash autocompletion for `kubectl` and `kubeadm` improves efficiency by reducing the amount of typing needed and helping to prevent command line mistakes.

1. **Enable Autocompletion for kubectl**:
   Generate the autocompletion script for `kubectl` and save it to the bash completion directory:

   ```bash
   kubectl completion bash > /etc/bash_completion.d/kubectl
   ```

2. **Enable Autocompletion for kubeadm**:
   Similarly, generate the autocompletion script for `kubeadm` and save it:

   ```bash
   kubeadm completion bash > /etc/bash_completion.d/kubeadm
   ```

3. **Activate the Autocompletion**:
   To activate the autocompletion without restarting your session, you can source the completion script:

   ```bash
   source /etc/bash_completion
   ```

   Alternatively, for immediate effect in your current shell session, source the individual completion files:

   ```bash
   source /etc/bash_completion.d/kubectl
   source /etc/bash_completion.d/kubeadm
   ```

4. **Verify Autocompletion**:
   Test that the autocompletion works by typing `kubectl get po` followed by the tab key. It should automatically complete to `kubectl get pods` if there are no conflicts with other commands starting similarly.

### Step 15: Manage kubeadm Tokens and Check API Version

Managing tokens ensures that your cluster remains secure by controlling which nodes can join the cluster and when. Additionally, checking the API resources helps understand the capabilities of your Kubernetes cluster.

1. **List Current Tokens**:
   Start by listing all the existing join tokens. This will display the tokens along with their expiration times and usages:

   ```bash
   kubeadm token list
   ```

2. **Delete Unnecessary Tokens**:
   If you find tokens that are no longer needed or have expired, you can delete them using their token ID. Replace `Token id` with the actual token you wish to delete:

   ```bash
   kubeadm token delete Token id
   ```

3. **Create a New Token**:
   To create a new token and generate a new join command for additional nodes, use the following command. It will create a new token and print the full `kubeadm join` command including the token:

   ```bash
   kubeadm token create --print-join-command
   ```

4. **Find API Version**:
   If you need to find out the available API versions for different resources within your cluster, you can list them using:

   ```bash
   kubectl api-resources
   ```

5. **Explain API resources**:
   If you need to know more about the API resources available in your cluster, you can use `kubectl explain <resource>` to get a detailed description of the resource.

   ```bash
   kubectl explain pod
   kubectl explain pod.metadata
   kubectl explain pod.spec
   kubectl explain pod.spec.containers
   ```

For those who are following the Kubernetes installation and setup steps or looking to extend their understanding of Kubernetes cluster administration, here are some valuable resources directly from the official Kubernetes documentation:

1. **Installing kubeadm**:
   Learn about the prerequisites and steps for installing `kubeadm`, a tool that makes it easier to set up and manage Kubernetes clusters:
   - [Install kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)

2. **Creating a Cluster with kubeadm**:
   This guide provides detailed instructions on how to use `kubeadm` to create a Kubernetes cluster, including initializing your master node, setting up networking, and adding worker nodes:
   - [Create a cluster with kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/)

3. **Kubernetes Addons**:
   Explore the various addons available for Kubernetes, which help extend the functionality of your cluster. This includes networking, monitoring, DNS, visualization, and more:
   - [Kubernetes Cluster Addons](https://kubernetes.io/docs/concepts/cluster-administration/addons/)
