# Ansible Orchestration
## This project aims to create and configure three CentOS-based SSH containers using Ansible.
### Prerequisites :
OS: CentOS Stream release 9 /
Install :  Java
          - Docker
          - Git
### 1.  Create a CentOS-SSH image using Dockerfile.
### 2.  Run the following command to add the user to the Docker group:
```
sudo usermod -aG docker <username>
````
```
logout or exit
```
### 3.  Build the Docker image:
```
docker build -t <image-name> <path-to-dockerfile>
```
### 4.  Check if the image was created:
```
docker images
```
### 5.  Create containers using the CentOS-SSH image:
```
docker run -d --name <container-name> <image-name>
```
### 6.  Check if containers were created:
```
docker ps -a
```
### 7.  Run the containers in detached mode:
```
docker-compose up -d
```
### 8.  Create an inventory file to define the nodes.
### 9.  Create an ansible playbook to generate SSH key pair and copy public key to nodes.
### 10.  Execute the playbook and enter the SSH password:

```
sudo su && cd ansible && ansible-playbook ssh-keygen-copy.yml -i inventory.ini --ask-pass
```
### 11.  Ping the managed nodes:
```
ansible -m ping all -i inventory.ini
```
<div align="center">
<img src="https://github.com/WiemFd/Ansible_Orchestration/assets/128514665/52c96eb6-bf26-4463-b51b-7401d67b98dd.png" width="700" height="350">
</div>
