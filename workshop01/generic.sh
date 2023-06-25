#!/bin/sh 
docker-machine create \
    --driver generic \
    --generic-ssh-user root \
    --generic-ip-address 143.198.204.164 \
    --generic-ssh-key ~/.ssh/id_rsa \
    --generic-ssh-port 22 \
    docker-nginx
