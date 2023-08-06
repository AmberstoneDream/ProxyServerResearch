# Create a Docker image from debian
FROM debian:latest

# Install sudo and OpenSSH
RUN apt-get update \
    && apt-get install -y sudo openssh-server \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Required for the "Missing privilege separation directory" error
RUN mkdir -p /run/sshd

# Add non-root user (name: "crafty", password: "crafty")
RUN useradd -m -d /home/crafty -s /bin/bash crafty
RUN echo 'crafty:crafty' | chpasswd
RUN adduser crafty sudo

# Expose ports:
# - Crafty Control: 8000 (HTTP), 8443 (HTTPS)
# - SSH: 22
# - Dynmap: 8123
# - Velocity proxy & Minecraft servers: 25500-25600
EXPOSE 22 8000 8443 8123 25500-25600

# Start SSH server
CMD ["/usr/sbin/sshd", "-D"]


# ---------- BUILD YOUR IMAGE ----------
# docker build -t crafty-control-debian .

# -------- RUN A DOCKER INSTANCE -------
# docker run -d -p 22:22 -p 8000:8000 -p 8443:8443 -p 8123:8123 -p 25500-25600:25500-25600 --name crafty_control crafty-control-debian