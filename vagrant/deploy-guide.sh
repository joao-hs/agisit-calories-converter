#!/bin/bash

source agisit24-g10/.env

gcloud auth login

gcloud config set project agisit24-g10

cd agisit24-g10/gcp
terraform init

ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa -N ""

terraform apply --auto-approve -var "CONTAINER_REGISTRY_PREFIX=$CONTAINER_REGISTRY_PREFIX"

sleep 30

ansible-playbook ansible-deploy-01-init.yml

ansible-playbook ansible-deploy-02-run-containers.yml --extra-vars "DB_USER=$DB_USER DB_PASSWORD=$DB_PASSWORD DB_NAME=$DB_NAME CONTAINER_REGISTRY_PREFIX=$CONTAINER_REGISTRY_PREFIX"
