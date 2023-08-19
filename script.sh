#!/bin/bash
# in a shell script
echo "...............Starting Magic Script............."
cd ~/

directory="app2"
if [ ! -d "$directory" ]; then
    mkdir -p "$directory"
    echo "Directory '$directory' created."
else
    echo "Directory '$directory' already exists."
fi
cd app2
echo "...............Downloading Profile repo............."
wget 'https://github.com/kamalkk2408/profile/archive/refs/heads/main.zip'

directory="profile"
if [ -d "$directory" ]; then
    rm -rf  "$directory"
fi
unzip main.zip -d ./profile
rm main.zip
cd profile

cd profile-main
pwd
echo "...............Generating maven build............."
mvn clean install
echo "...............Maven build completed............."


echo "...............Generating docker build............."
docker build -t profile:1.0 .
echo "...............Generated docker build............."


echo "...............Generating k8 deployment............."
kubectl apply -f deployment.yaml
echo "...............Generated k8 build............."
kubectl get pods

echo "...............Generating k8 service............."
kubectl apply -f service.yaml
echo "...............Generated k8 service............."
kubectl get service



echo "...............Below are k8 node & service details............."
kubectl get node -o wide
kubectl get service
