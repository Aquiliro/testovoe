FROM ubuntu:24.04

RUN apt-get update && \
    apt-get install -y openssh-server sudo && \
    rm -rf /var/lib/apt/lists/*
RUN mkdir -p /run/sshd
RUN useradd -m -s /bin/bash bair && \
    echo 'bair:password' | chpasswd && \
    adduser bair sudo && \
    echo "bair ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

EXPOSE 22 80
CMD ["/usr/sbin/sshd", "-D"]
