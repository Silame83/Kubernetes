#!/bin/bash

#Install VirtualBox
egrep -c '(vmx|svm)' /proc/cpuinfo
cat /sys/hypervisor/properties/capabilities
kvm-ok
egrep -c ' lm ' /proc/cpuinfo
curl -lO https://download.virtualbox.org/virtualbox/6.0.8/virtualbox-6.0_6.0.8-130520~Ubuntu~bionic_amd64.deb
apt install $HOME/virtualbox*.deb


#Install kubectl
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

#install Minikube by downloading a static binary
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube

#Add Minikube execute to path
sudo cp minikube /usr/local/bin && rm minikube

#run Minikube
minikube start
