#!/bin/bash

source agisit24-g10/.env

cd agisit24-g10/gcp

ansible-playbook ansible-takedown-01-delete-containers.yml --extra-vars "CONTAINER_REGISTRY_PREFIX=$CONTAINER_REGISTRY_PREFIX"

terraform destroy --auto-approve -var "CONTAINER_REGISTRY_PREFIX=$CONTAINER_REGISTRY_PREFIX"
