#!/bin/bash 

#BREW
which -s brew
if [[ $? != 0 ]];
    then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    brew update
fi

#DOCKER
which -s docker
if [[ $? != 0 ]];
    then
    brew install docker
fi

#DOCKER-MACHINE
which -s docker-machine
if [[ $? != 0 ]];
    then
    brew install docker-machine
fi

docker-machine start;
# eval "$(docker-machine env default)";

#MINIKUBE
which -s minikube
if [[ $? != 0 ]];
    then
    brew install minikube
fi


