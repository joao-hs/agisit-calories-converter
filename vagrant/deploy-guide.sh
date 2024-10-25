#!/bin/bash

source agisit24-g10/.env

cd agisit24-g10/gcp

terraform apply --auto-approve

sleep 15

ansible-playbook ansible-deploy-00-gcp-configure-nodes.yml

ansible-playbook ansible-deploy-01-init.yml

ansible-playbook ansible-deploy-02-rmcicd.yml

ansible-playbook ansible-deploy-03-run-containers.yml

WEB=$(cat inventory.ini | grep 'fe1 ansible_host=' | cut -d'=' -f2 | awk '{print $1}') 
GRAFANA=$(cat inventory.ini | grep 'rmcicd ansible_host=' | cut -d'=' -f2 | awk '{print $1}')

echo "Application is running at http://$WEB"
echo "Grafana is running at http://$GRAFANA:3000. Login with username: \"admin\", password: \"admin\""