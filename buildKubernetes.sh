#!/bin/bash
# ---------------------- install kube* -------------------------------------
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
apt-get install -y kubelet kubeadm kubectl
echo "KUBELET_EXTRA_ARGS=--cgroup-driver=systemd" > /etc/default/kubelet
systemctl daemon-reload
systemctl restart kubelet

# ---------------------- check and build Kubernetes cluster via Flunnel--------------
kubeadm init --pod-network-cidr=10.244.0.0/16
sleep 10
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
export KUBECONFIG=/etc/kubernetes/admin.conf
echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/a70459be0084506e4ec919aa1c114638878db11b/Documentation/kube-flannel.yml
kubectl get pods --all-namespaces
sleep 5
