# Ansible Orchestration
## This project aims to create and configure three CentOS-based SSH containers using Ansible.
### Prerequisites :
OS: CentOS Stream release 9 /
Install :  Java
          - Docker
          - Git - SSH
```
sudo su
```
### 1.  Build the Docker image:
```
cd Centos-SSH && docker build -t centos-ssh .
```
### 2.  Check if the image was created:
```
docker images
```
### 3.  Create and start containers in detached mode:
In a Docker Compose configuration file (docker-compose.yml), it is essential to launch each container with extended privileges and execute the system initialization process inside it to have control over services.
```
cd .. & docker-compose up -d
```
### 4.  Check if containers were created:
```
docker ps -a
```
### 5.  Check if the network was created:
```
docker network ls
```
### 6.  Execute the playbook SSH_Keygen_Copy.yml and enter the SSH password:

After creating an inventory file to define the remote nodes, it's important to generate an SSH key pair and copy the public key to remote nodes. This allows for passwordless authentication in Ansible. The `--ask-pass` option is used to enter the password only during the initial setup. <br>
The SSH password is set in the Dockerfile "access_ssh".
```
cd ansible && ansible-playbook PLAYBOOKs/SSH_Keygen_Copy.yml -i inventory.ini --ask-pass
```
<div align="center">
<img src="https://github.com/WiemFd/Ansible_Orchestration/assets/128514665/ded89c1a-4152-415f-9005-ae4b83bf74d9.png" width="700" height="350">
</div>

### 7. Test SSH connection to a remote node without password: 
Locate the IP address of a container:
```
docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <containerID|container-name>
```
Test SSH connection to the container as a remote node:
```
ssh root@192.168.1.23
```
### 8.  Ping the managed nodes:
```
ansible -m ping all -i inventory.ini
```
<div align="center">
<img src="https://github.com/WiemFd/Ansible_Orchestration/assets/128514665/79546410-6e18-4d4c-8b1f-7d3ea5282cc9.png" width="700" height="350">
</div>

### 9.  Test {Hello World} playbook :
```
ansible-playbook PLAYBOOKs/Hello_World_From.yml -i inventory.ini
```
<div align="center">
<img src="https://github.com/WiemFd/Ansible_Orchestration/assets/128514665/f767eb01-c11e-4b00-ba15-b4366c6b6421.png" width="700" height="350">
</div>

### 10.  Test {Nginx} playbook:
Install and start nginx web server on one of remote nodes.
```
ansible-playbook PLAYBOOKs/NGINX_Web_Server/nginx.yml -i inventory --limit 192.168.1.23
```
<div align="center">
<img src="https://github.com/WiemFd/Ansible_Orchestration/assets/128514665/9f5f541f-7d04-4ee8-9421-277a2e1bfc50" width="700" height="350">
</div>

Try to connect to this node by running the following command:
```
ssh root@192.168.1.23
```
Then, Ensure that the service has been started:
```
systemctl status nginx
```
<div align="center">
<img src="https://github.com/WiemFd/Ansible_Orchestration/assets/128514665/d21c087a-0c0f-480d-9b1b-9f1eb3441a9e" width="700" height="350">
</div>

```
exit
```
Open a web browser and enter the following URL :
```
192.168.1.23:80
```
If everything is correctly set up, this page will be displayed :
<div align="center">
<img src="https://github.com/WiemFd/Ansible_Orchestration/assets/128514665/80f656c2-6c62-488b-9484-1a723a8ef178" width="600" height="400">
</div>

###  11.  Test {nodes information} playbook :
This playbook collects information about the managed nodes. It gathers facts about the system, such as the hostname, user, group name, IP address, operating system, CPU and System time. Besides, there are two commented lines in the playbook that can be activated to gather more information about the disk space and installed packages on each node.
```
ansible-playbook -i inventory.ini PLAYBOOKs/Nodes_Information.yml
```
<div align="center">
<img src="https://github.com/WiemFd/Ansible_Orchestration/assets/128514665/93f7d4b4-e270-4ba1-b610-5c0cf87c0055" width="700" height="350">
</div>

### 12. Test {collect files from nodes} playbook :
Make sure you have created a file named myfile.txt on each target node. <br>
Execute this playbook to collect all files from nodes to the ansible engine node:
```
ansible-playbook -i inventory.ini PLAYBOOKs/Collect_Files/collect_works.yml 
```
<div align="center">
<img src="https://github.com/WiemFd/Ansible_Orchestration/assets/128514665/91a6f3fd-7757-4115-9e12-4d1634f75c48" width="700" height="350">
</div>

After the playbook execution, a directory named "works" has been created on the ansible node.<br>
Inside the "works" directory, you will find the collected files from each node. The directory structure will be organized based on the hostname of each node.

<div align="center">
<img src="https://github.com/WiemFd/Ansible_Orchestration/assets/128514665/27b2c7dd-1098-49ee-aefc-7c9a2bfb0cd0" width="200" height="200">
</div>

By using the default value of "flat: no" in the playbook, the files collected from multiple hosts with the same filename will not overwrite each other. This ensures that each file is preserved with its original name and avoids conflicts in the collected files.
