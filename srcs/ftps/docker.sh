#!/bin/bash

eval $(docker-machine env default)
docker rm -f f1
docker rmi f1
docker build -t f1 .
docker-machine ip
docker run -it -p 21:21 -p 21100-21102:21100-21102 --name f1 f1
