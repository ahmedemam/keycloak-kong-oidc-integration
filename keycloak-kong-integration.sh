#!/bin/bash

docker container prune
docker image prune
docker network prune
docker volume prune

if [ $1 == "--start" ]; then
    mkdir /sys/fs/cgroup/systemd
    mount -t cgroup -o none,name=systemd cgroup /sys/fs/cgroup/systemd
    docker-compose -f docker-compose-keycloak.yml up --build -d
    docker-compose -f docker-compose-kong.yml up --build -d
fi

if [ $1 == "--stop" ]; then
    docker-compose -f docker-compose-keycloak.yml down --remove-orphans
    docker-compose -f docker-compose-kong.yml down --remove-orphans
fi
