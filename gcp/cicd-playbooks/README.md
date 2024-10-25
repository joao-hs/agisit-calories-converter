### Ansible Playbooks to be used in RMCICD instance

- `ansible-deploy.yml`: Set the active deployment to be running the most updated Docker images stored in Docker Registry, with minimal downtime. This won't stop containers that are already running the latest images.