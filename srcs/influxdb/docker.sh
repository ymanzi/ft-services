#!/bin/bash

eval $(docker-machine env default)
docker rm -f i1
docker rmi i1
docker build -t i1 .
docker run -d -p 8086:8086 --name i1 i1
