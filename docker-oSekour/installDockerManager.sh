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

# install portainer CE
echo -e "## Installation de Portainer\n"
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:2.21.5
sleep 3
clear
# init Docker Swarm
recupIP=$(ip a | grep dynamic | awk '{print $2}' | awk -F "/" '{print $1}')
echo -e "## Inistialisation du Swarm\n"
docker swarm init --advertise-addr $recupIP > ./initSwarm.txt

# install oSekour
echo -e "## Installation de oSekour\n"
git clone https://github.com/pmaldi/oSekour.git
### cd oSekour/
FICHIER=./oSekour/dockerfile.multi-stage
if [ -f "$FICHIER" ]; then
	rm $FICHIER
fi
echo -e '#### syntax=docker/dockerfile: with node:lts-slim\nFROM node:lts-slim AS builder\nWORKDIR /app\nCOPY package*.json ./\nRUN npm install\nCOPY . .\nRUN npm run build\n\n# Stage 2: Create the production image version slim\nFROM nginx:stable-alpine3.20-slim\nCOPY --from=builder /app/dist /usr/share/nginx/html\nEXPOSE 80\nCMD ["nginx", "-g", "daemon off;"]' > ./oSekour/dockerfile.multi-stage

docker build ./oSekour/ -t osekour-multi-stage:slim -f ./oSekour/dockerfile.multi-stage

clear
echo -e "******************************"
cat ./initSwarm.txt
echo -e "\n"
echo -e "## Pour lancer oSekour :"
echo -e "docker service create -q --name osekour --publish published=80,target=80,mode=host --constraint node.role==manager osekour-multi-stage:slim"
echo -e "\n"
echo -e "## pour rejoindre Portainer : https://$recupIP:9443/\n## Si vous avez un Time Out utilisez la commande\ndocker restart portainer\n"
echo -e "## pour rejoindre oSekour : http://$recupIP/"
echo -e "\n"
echo -e "******************************"


