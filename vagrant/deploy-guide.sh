#!/bin/bash

source agisit24-g10/.env

gcloud auth login

gcloud config set project agisit24-g10

cd agisit24-g10/gcp
terraform init

ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa -N ""

terraform apply --auto-approve
sleep 15

# CA private key and self-signed certificate
openssl genrsa -out secrets/ca.key 2048
openssl req -x509 -new -nodes -key secrets/ca.key -sha256 -days 3650 -out secrets/ca.crt -config config-files/ca.cnf

mkdir -p resources


ansible-playbook ansible-deploy-00-gcp-configure-nodes.yml

ansible-playbook ansible-deploy-01-init.yml

ansible-playbook ansible-deploy-02-rmcicd.yml

ansible-playbook ansible-deploy-03-run-containers.yml
