#!/bin/bash

#install Minikube by downloading a static binary
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && chmod +x minikube

#Minikube execute
sudo cp minikube /usr/local/bin && rm minikube

#run Minikube
minikube start