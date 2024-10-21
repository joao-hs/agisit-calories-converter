#!/bin/bash

source agisit24-g10/.env

gcloud auth login

gcloud config set project agisit24-g10

# gcloud projects add-iam-policy-binding agisit24-g10 --member=serviceAccount:831095138059-compute@developer.gserviceaccount.com --role=roles/compute.admin

cd agisit24-g10/k8s
terraform init

ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa -N ""

terraform apply -auto-approve

ansible-playbook ansible-gcp-configure-nodes.yml

ansible-playbook ansible-k8s-install.yml

ansible-playbook ansible-create-cluster.yml

ansible-playbook ansible-workers-join.yml

ansible-playbook ansible-helm-install.yml

./scripts/fill-secrets.sh ../.env

ansible-playbook ansible-publish-secrets.yml

export CONTAINER_REGISTRY_PREFIX # must be defined in .env
./scripts/substitute-container-registry.sh .

ansible-playbook ansible-start-deployment.yml

terraform destroy -auto-approve