#!/bin/bash

export MINIKUBE_HOME=/Users/ymanzi/goinfre
minikube stop
minikube delete
minikube start --vm-driver=virtualbox
#minikube start

#------------------- Docker environment Minikube --------------------------
eval $(minikube docker-env)
