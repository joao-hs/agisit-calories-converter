#!/bin/bash

gcloud auth login

gcloud config set project agisit24-g10

cd k8s
terraform init

ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa -N ""

terraform apply -auto-approve

ansible-playbook ansible-gcp-configure-nodes.yml

ansible-playbook ansible-k8s-install.yml

ansible-playbook ansible-create-cluster.yml

ansible-playbook ansible-workers-join.yml

./scripts/fill-secrets.sh

ansible-playbook ansible-start-deployment.yml