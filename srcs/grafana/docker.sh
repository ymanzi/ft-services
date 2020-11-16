#!/bin/bash

eval $(docker-machine env default)
docker rm -f g1
docker rmi g1
docker build -t g1 .
docker run -d -p 3000:3000 --name g1 g1
