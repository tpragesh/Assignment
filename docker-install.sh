#!/bin/bash
sudo apt-get update -y 
sudo apt-get install ca-certificates curl gnupg lsb-release -y
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
# sudo docker run -d -p 80:80 nginx
# docker run -d -p80:80 --name=knab-nginx nginx
docker run -d --name knab-nginx --log-driver=awslogs --log-opt awslogs-group="knab-nginx" --log-opt awslogs-create-group=true -p 80:80 nginx
sleep 10
docker container update --restart unless-stopped knab-nginx
