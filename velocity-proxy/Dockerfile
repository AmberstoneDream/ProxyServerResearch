# Create a Docker image from ubuntu
FROM ubuntu:latest

# Install sudo, wget, OpenSSH and OpenJDK 17
RUN apt-get update \
    && apt-get install -y sudo wget openjdk-17-jdk openssh-server \
    && rm -rf /var/lib/apt/lists/*

# Required for the "Missing privilege separation directory" error
RUN mkdir -p /run/sshd

# Add non-root user (name: "velocity", password: "velocity")
RUN useradd -m -d /home/velocity -s /bin/bash velocity
RUN echo 'velocity:velocity' | chpasswd
RUN usermod -aG sudo velocity

# Expose ports:
# - Velocity proxy: 25577
# - SSH: 22
EXPOSE 22 25577

# Start SSH server
CMD ["/usr/sbin/sshd", "-D"]


# ---------- BUILD YOUR IMAGE ----------
# docker build -t velocity-proxy-server .

# -------- RUN A DOCKER INSTANCE -------
# docker run -d -p 22:22 -p 25577:25577 --name minecraft_server velocity-proxy-server


# ---------------- TIPS ----------------
#
# Add user:
#   sudo adduser john_doe
#
# Change password:
#   passwd john_doe
#
# Give sudo access:
#   sudo usermod -aG sudo john_doe
#
# Password generator:
#   https://passwordsgenerator.net/
#
# Windows SSH connection:
#   ssh -t john_doe@localhost -p 22
#