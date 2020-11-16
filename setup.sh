#!/bin/bash

echo "\n#--------------------------MINIKUBE SETUP--------------------------------\n"

#checking if brew is installed
which -s brew
if [[ $? != 0 ]] ; then
	echo "Installing Brew..."
	rm -rf $HOME/.brew && git clone --depth=1 https://github.com/Homebrew/brew $HOME/.brew && export PATH=$HOME/.brew/bin:$PATH && brew update && echo "export PATH=$HOME/.brew/bin:$PATH" >> ~/.zshrc &> /dev/null
fi

#checking if minikube is installed
which -s minikube
if [[ $? != 0 ]] ; then
	echo -ne "\033[1;31m+>\033[0;33m Minikube installation ...\n"
	if brew install minikube &> /dev/null
	then
		echo -ne "\033[1;32m+>\033[0;33m Minikube installed ! \n"
	else
		echo -ne "\033[1;31m+>\033[0;33m Error... During minikube installation. \n"
		return 0
	fi
fi

echo "set minikube_home"
export MINIKUBE_HOME=/Users/$(whoami)/goinfre

echo "Deleting previous cluster if there is one"
minikube delete

echo "Starting Minikube (it might take a while)"
minikube start --vm-driver=virtualbox
eval $(minikube docker-env)
echo "#------------------ ADDONS MINIKUBE ------------------------------"

minikube addons enable dashboard
minikube addons enable metallb
minikube addons enable metrics-server

echo "\n#-------------------------------- LUNCH DASHBOARD ----------------------------\n"
minikube dashboard &

echo "\n#-------------------------- METALLB CONFIG ------------------------------\n"

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml

#ConfigMap MetalLB
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f srcs/yaml/metallb-configmap.yaml

echo "\n#------------------------------- REQUEST VOLUMES ----------------------------\n"

kubectl apply -f srcs/yaml/mysqlvol.yaml
kubectl apply -f srcs/yaml/influxdbvol.yaml

echo "\n#----------------------------- NGINX  IMAGE BUILD ----------------------------\n"

docker rmi nginx_i
docker build -t nginx_i srcs/nginx/.

echo "\n#--------------------------- WORDPRESS IMAGE BUILD ----------------------------\n"

#docker rmi wordpress_i
docker build -t wordpress_i srcs/wordpress/.

echo "\n#------------------------------ MYSQL IMAGE BUILD ----------------------------\n"

#docker rmi mysql_i
kubectl apply -f srcs/yaml/mysql.yaml
docker build -t mysql_i srcs/mysql/.

echo "\n#---------------------------- PHPMYADMIN IMAGE BUILD ----------------------------\n"

docker rmi phpmyadmin_i
docker build -t phpmyadmin_i srcs/phpmyadmin/.

echo "\n#------------------------------- FTPS IMAGE BUILD ----------------------------\n"

#docker rmi ftps_i
docker build -t ftps_i srcs/ftps/.

echo "\n#------------------------------ INFLUXDB IMAGE BUILD ----------------------------\n"

#docker rmi influxdb_i
docker build -t influxdb_i srcs/influxdb/.

echo "\n#------------------------------ GRAFANA IMAGE BUILD ----------------------------\n"

#docker rmi grafana_i
docker build -t grafana_i srcs/grafana/.

echo "\n#----------------------------------- SETUP K8s ----------------------------\n"
echo "\n#----------------------------------- FTPS CLUSTER ----------------------------\n"
kubectl apply -f srcs/yaml/ftps.yaml

echo "\n#--------------------------------- NGINX CLUSTER ----------------------------\n"
kubectl apply -f srcs/yaml/nginx.yaml

echo "\n#-------------------------------- WORDPRESS CLUSTER ----------------------------\n"
kubectl apply -f srcs/yaml/wordpress.yaml


echo "\n#-------------------------------- GRAFANA CLUSTER ----------------------------\n"
kubectl apply -f srcs/yaml/grafana.yaml

echo "\n#-------------------------------- INFLUXDB CLUSTER ----------------------------\n"
kubectl apply -f srcs/yaml/influxdb.yaml

echo "\n#------------------------------- PHPMYADMIN CLUSTER ----------------------------\n"
kubectl apply -f srcs/yaml/phpmyadmin.yaml

echo "\n#----------------------------------- MYSQL CLUSTER ----------------------------\n"
kubectl exec -i $(kubectl get pods | grep mysql | cut -d" " -f1) -- mysql wordpress -u root < srcs/mysql/wordpress.sql


echo "\n#----------------------------------- SETUP K8s DONE ----------------------------\n"

