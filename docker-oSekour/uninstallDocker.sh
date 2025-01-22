#!/bin/bash

apt purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
rm -rf /var/lib/docker
rm -rf /var/lib/containerd
rm /etc/apt/sources.list.d/docker.list
rm /etc/apt/keyrings/docker.asc
rm -R ./oSekour
apt update

