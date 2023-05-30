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
docker build -t <image-name> <path-to-dockerfile>
```
### 2.  Check if the image was created:
```
docker images
```
### 3.  Create containers using the CentOS-SSH image:
```
docker run -d --name <container-name> <image-name>
```
### 4.  Check if containers were created:
```
docker ps -a
```
### 5.  Run the containers in detached mode:
```
docker-compose up -d
```
### 6.  Execute the playbook ssh-keygen-copy.yml and enter the SSH password:

After creating an inventory file to define the remote nodes, it's important to generate an SSH key pair and copy the public key to the nodes. This allows for passwordless authentication in Ansible. The `--ask-pass` option is used to enter the password only during the initial setup.
```
cd ansible && ansible-playbook ssh-keygen-copy.yml -i inventory.ini --ask-pass
```
### 7. Test SSH connection to a remote node without password: 
Locate the IP address of a container:
```
docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <containerID|container-name>
```
Test SSH connection to the container as a remote node:
```
ssh root@192.168.10.3
```
### 8.  Ping the managed nodes:
```
ansible -m ping all -i inventory.ini
```
<div align="center">
<img src="https://github.com/WiemFd/Ansible_Orchestration/assets/128514665/52c96eb6-bf26-4463-b51b-7401d67b98dd.png" width="700" height="350">
</div>
### 9. Test Hello-World playbook :
```
ansible-playbook HelloWorld.yml -i inventory.ini
```
