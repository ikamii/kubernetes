# Use Ubuntu 20.04 LTS as the base image
FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Update and install sudo, Python, and openssh-server
RUN apt-get update && apt-get install -y sudo python3 openssh-server

# Create a symlink for Python3 to Python
RUN ln -s /usr/bin/python3 /usr/bin/python

# Create a new user `testuser` and add it to the `sudo` group
RUN adduser --disabled-password --gecos "" testuser && \
    usermod -aG sudo testuser

# Enable passwordless sudo for users under the "sudo" group
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# SSH login fix. Otherwise, the user is kicked off after login
RUN sed -i 's/.*PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Setup SSH daemon
RUN mkdir /var/run/sshd

# Switch to your new user in the docker image
USER testuser

# Set the default working directory for the container
WORKDIR /home/testuser

# Expose the SSH port
EXPOSE 22

# Run SSH daemon
CMD ["/usr/sbin/sshd", "-D"]
