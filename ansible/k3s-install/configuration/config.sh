#!/bin/bash
set -e

KUBE_DIR=/home/$USER/.kube
KUBE_CONFIG=$KUBE_DIR/config

function create_config() {
    sudo cp /etc/rancher/k3s/k3s.yaml $KUBE_CONFIG
    sudo chown $USER $KUBE_CONFIG
    sudo chmod 600 $KUBE_CONFIG

    # Configure .bashrc to use KUBECONFIG
    if ! [[ $(grep "export KUBECONFIG" /home/$USER/.bashrc) ]]; then
        echo "export KUBECONFIG=$KUBE_CONFIG" >> /home/$USER/.bashrc
        bash --login; exit
    fi
}

# Create ~/.kube/ directory if it doesn't exist
if ! [[ -d $KUBE_DIR ]]; then
    mkdir -p $KUBE_DIR
fi

# Create config
create_config