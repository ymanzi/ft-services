#!/bin/bash

eval $(docker-machine env default)
docker rm -f m1
docker rmi m1
docker build -t m1 .
docker run -d -p 3306:3306 --name m1 m1
