FROM centos:latest

# Set the base URL to the CentOS Vault
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

# Comment out the mirrorlist and use the base URL instead
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*

# Install SSH packages and create directory for SSH daemon
RUN yum -y install openssh openssh-server openssh-clients
RUN mkdir -p /var/run/sshd

# Generate SSH host key and set root password
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
RUN echo 'root:access_ssh' | chpasswd

# Allow root login and enable password authentication
RUN sed -ri 's/^#PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# Expose port 22 for SSH
EXPOSE 22

# Start SSH daemon
CMD ["/usr/sbin/sshd", "-D"]
