FROM ubuntu:24.04

RUN apt-get update && \
    apt-get install -y ansible rsync && \
    rm -rf /var/lib/apt/lists/*

RUN ansible-galaxy collection install ansible.posix
