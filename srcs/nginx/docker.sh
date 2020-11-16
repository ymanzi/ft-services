#!/bin/bash

eval $(docker-machine env default)
docker rm -f n1
docker rmi n1
docker build -t n1 .
docker run -d -p 80:80 -p 443:443 --name n1 n1
