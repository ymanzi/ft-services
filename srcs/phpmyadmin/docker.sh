#!/bin/bash

eval $(docker-machine env default)
docker rm -f p1
docker rmi p1
docker build -t p1 .
docker run -d -p5000:5000 -p443:443 --name p1 p1
docker-machine ip
