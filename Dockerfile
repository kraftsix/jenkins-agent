FROM ubuntu:latest

LABEL maintainer="docker@kraft6.com"

# Install SSH server and utilities
RUN apt-get update && apt-get install -y openssh-server sudo openjdk-17-jre && \
    mkdir /var/run/sshd

# Add user 'jenkins' with password 'jenkins' (replace 'jenkins' with the desired password)
RUN useradd -m jenkins && \
    echo 'jenkins:jenkins' | chpasswd && \
    usermod -aG sudo jenkins && \
    chown -R jenkins:jenkins /home/jenkins

# Allow SSH access for 'john'
RUN mkdir -p /home/jenkins/.ssh && \
    chmod 700 /home/jenkins/.ssh 
# Expose SSH port
EXPOSE 22

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]
