#!/usr/bin/env bash

# on ubuntu-v18.0.4TLS
# Uninstall old versions
# Older versions of Docker were called docker, docker.io , or docker-engine. If these are installed, uninstall them:

Ou135246Ou

sudo apt-get remove docker docker-engine docker.io containerd runc

sudo apt-get update

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

# Add Docker��s official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io

# k8s bin
# wget https://storage.googleapis.com/kubernetes-release/release/v1.15.0-rc.1/kubernetes-server-linux-amd64.tar.gz
wget https://storage.googleapis.com/kubernetes-release/release/v1.14.3/kubernetes-server-linux-amd64.tar.gz

echo 'PATH=/fff/kubernetes/server/bin:$PATH' >>/root/.bashrc
source /root/.bashrc

# �ر� swap ����
# ��������� swap ������kubelet ������ʧ��(����ͨ�������� --fail-swap-on ����Ϊ false ������ swap on)��
#    ����Ҫ��ÿ̨�����Ϲر� swap ������ͬʱע�� /etc/fstab ����Ӧ����Ŀ����ֹ�����Զ����� swap ������
swapon -s # ��
swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# ��������
shutdown -r 0

# kubeadm init --kubernetes-version=v1.15.0-rc.1
kubeadm init


# Note: This dropin only works with kubeadm and kubelet v1.11+
[Service]
Environment="KUBELET_KUBECONFIG_ARGS=--bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf"
Environment="KUBELET_CONFIG_ARGS=--config=/var/lib/kubelet/config.yaml"
# This is a file that "kubeadm init" and "kubeadm join" generates at runtime, populating the KUBELET_KUBEADM_ARGS variable dynamically
EnvironmentFile=-/var/lib/kubelet/kubeadm-flags.env
# This is a file that the user can use for overrides of the kubelet args as a last resort. Preferably, the user should use
# the .NodeRegistration.KubeletExtraArgs object in the configuration files instead. KUBELET_EXTRA_ARGS should be sourced from this file.
EnvironmentFile=-/etc/sysconfig/kubelet
ExecStart=
ExecStart=/usr/bin/kubelet $KUBELET_KUBECONFIG_ARGS $KUBELET_CONFIG_ARGS $KUBELET_KUBEADM_ARGS $KUBELET_EXTRA_ARGS