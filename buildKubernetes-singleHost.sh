#!/bin/bash

#Docker install
apt-get update && apt-get install -qy docker.io

#Install apt-repository Kubernetes
apt-get update && apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

#Install kubelet, kubeadm, kubernetes-cni
apt-get update
apt-get install -y kubelet kubeadm kubernetes-cni

#Kubernetes API translation
#--pod-network-cidr  CIDR netmask for containers
#--apiserver-advertise-address  Kubernetes API-server public IP-address
#--skip-preflight-checks  kubeadm skip checks host kernel for exist functions
#--kubernetes-version stable-1.6  hard choice cluster version
kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=10.80.75.9 --skip-preflight-checks --kubernetes-version stable-1.6

#Packet Ubuntu user add
useradd packet -G sudo -m -s /bin/bash
passwd packet=Pt123456

sudo su packet
cd $HOME
sudo whoami
sudo cp /etc/kubernetes/admin.conf $HOME/
sudo chown $(id -u):(id -g) $HOME/admin.conf
echo "export KUBECONFIG=$HOME/admin.conf" | tee -a ~/.bashrc

#Apply network configuration for pods(flannel)
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel-rbac.yml
kubectl create -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

#Initial single-host cluster
kubectl taint nodes --all node-role.kubernetes.io/master-

#Check working cluster
kubectl get all --namespace=kube-system

#Load container
kubectl get pods

#For templates:
#kubectl run guids --image=alexellis2/guid-service:latest --port 9000

#For dashboard
kubectl create -f https://git.io/kube-dashboard
kubectl proxy
