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
docker build -t centos-ssh .
```
### 2.  Check if the image was created:
```
docker images
```
### 3.  Create and start containers in detached mode:
In a Docker Compose configuration file (docker-compose.yml), it is essential to launch each container with extended privileges and execute the system initialization process inside it to have control over services.
```
docker-compose up -d
```
### 4.  Check if containers were created:
```
docker ps -a
```
### 5.  Execute the playbook ssh-keygen-copy.yml and enter the SSH password:

After creating an inventory file to define the remote nodes, it's important to generate an SSH key pair and copy the public key to the nodes. This allows for passwordless authentication in Ansible. The `--ask-pass` option is used to enter the password only during the initial setup. <br>
The SSH password is set in the Dockerfile "access_ssh".
```
cd ansible && ansible-playbook ssh-keygen-copy.yml -i inventory.ini --ask-pass
```
<div align="center">
<img src="https://github.com/WiemFd/Ansible_Orchestration/assets/128514665/ded89c1a-4152-415f-9005-ae4b83bf74d9.png" width="700" height="350">
</div>

### 6. Test SSH connection to a remote node without password: 
Locate the IP address of a container:
```
docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <containerID|container-name>
```
Test SSH connection to the container as a remote node:
```
ssh root@192.168.10.3
```
### 7.  Ping the managed nodes:
```
ansible -m ping all -i inventory.ini
```
<div align="center">
<img src="https://github.com/WiemFd/Ansible_Orchestration/assets/128514665/79546410-6e18-4d4c-8b1f-7d3ea5282cc9.png" width="700" height="350">
</div>

### 8.  Test Hello-World playbook :
```
ansible-playbook HelloWorld.yml -i inventory.ini
```
<div align="center">
<img src="https://github.com/WiemFd/Ansible_Orchestration/assets/128514665/f767eb01-c11e-4b00-ba15-b4366c6b6421.png" width="700" height="350">
</div>
