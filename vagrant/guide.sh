#!/bin/bash

gcloud auth login

gcloud config set project agisit24-g10

terraform init

ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa -N ""

terraform apply -auto-approve
