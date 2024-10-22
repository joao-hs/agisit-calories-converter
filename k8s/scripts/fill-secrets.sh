#!/bin/bash

source $1

SCRIPT_DIR=$(dirname "$0")

TMPL_FILE=$(realpath "$SCRIPT_DIR/../templates/k8s-secrets.yaml")
OUT_FILE=$(realpath "$SCRIPT_DIR/../secrets/k8s-secrets.yaml")

if [ -z "DB_NAME" ]; then
    read -p "Enter the database name: " dbname
else
    dbname=$DB_NAME
fi

if [ -z "DB_USER" ]; then
    read -p "Enter the database user: " dbuser
else
    dbuser=$DB_USER
fi

dbpassword=$(openssl rand -base64 12)
# harborpassword=$(openssl rand -base64 12)
# harborsecretkey=$(openssl rand -base64 12)
if [ -z "$DOCKERHUB_REGISTRY_SERVER" ]; then
    read -p "Enter the container registry server: (DockerHub: https://index.docker.io/v1/) " containerregistryserver
else
    containerregistryserver=$DOCKERHUB_REGISTRY_SERVER
fi
if [ -z "$DOCKER_LOGIN_USERNAME" ]; then
    read -p "Enter the container registry username: " containerregistryusername
else
    containerregistryusername=$DOCKER_LOGIN_USERNAME
fi
if [ -z "$DOCKER_LOGIN_PAT" ]; then
    read -sp "Enter the container registry password: " containerregistrypassword
    echo
else
    containerregistrypassword=$DOCKER_LOGIN_PAT
fi

if [ -z "$DOCKERHUB_EMAIL" ]; then
    read -p "Enter the container registry email: " containerregistryemail
else
    containerregistryemail=$DOCKERHUB_EMAIL
fi
#
export PLACEHOLDER_B64_DBNAME=$(echo -n $dbname | base64 -w 0)
export PLACEHOLDER_B64_DBUSER=$(echo -n $dbuser | base64 -w 0)
export PLACEHOLDER_B64_DBPASSWORD=$(echo -n $dbpassword | base64 -w 0)
#export PLACEHOLDER_B64_DBURL=$(echo -n "postgresql://$dbuser:$dbpassword@db.default.svc.cluster.local:5432/$dbname" | base64)
# export PLACEHOLDER_B64_HARBORPASSWORD=$(echo -n $harborpassword | base64 -w 0)
# export PLACEHOLDER_B64_HARBORSECRETKEY=$(echo -n $harborsecretkey | base64 -w 0)
export PLACEHOLDER_B64_CONTAINERREGISTRYSERVER=$(echo -n $containerregistryserver | base64 -w 0)
export PLACEHOLDER_B64_CONTAINERREGISTRYUSERNAME=$(echo -n $containerregistryusername | base64 -w 0)
export PLACEHOLDER_B64_CONTAINERREGISTRYPASSWORD=$(echo -n $containerregistrypassword | base64 -w 0)
export PLACEHOLDER_B64_CONTAINERREGISTRYEMAIL=$(echo -n $containerregistryemail | base64 -w 0)


envsubst < $TMPL_FILE > $OUT_FILE

echo "Secrets have been updated in $OUT_FILE"
# echo "Database password: $dbpassword"
# echo "Harbor password: $harborpassword"
# echo "Harbor secret key: $harborsecretkey"