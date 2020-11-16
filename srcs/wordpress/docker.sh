#!/bin/bash

eval $(docker-machine env default)
docker rm -f w1
docker rmi w1
docker build -t w1 .
docker run -d -p 5050:5050 --name w1 w1
