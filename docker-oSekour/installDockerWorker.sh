#!/bin/bash

# intall docker
apt update
clear
echo -e "## Installation de Docker\n"
apt install -y ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release && echo "$ID")/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/$(. /etc/os-release && echo "$ID") $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sleep 3

# install oSekour
echo -e "## Installation de oSekour\n"
git clone https://github.com/pmaldi/oSekour.git
### cd oSekour/
echo -e '#### syntax=docker/dockerfile: with node:lts-slim\nFROM node:lts-slim AS builder\nWORKDIR /app\nCOPY package*.json ./\nRUN npm install\nCOPY . .\nRUN npm run build\n\n# Stage 2: Create the production image version slim\nFROM nginx:stable-alpine3.20-slim\nCOPY --from=builder /app/dist /usr/share/nginx/html\nEXPOSE 80\nCMD ["nginx", "-g", "daemon off;"]' > ./oSekour/dockerfile.multi-stage

docker build ./oSekour/ -t osekour-multi-stage:slim -f ./oSekour/dockerfile.multi-stage
