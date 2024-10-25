# Secrets

This directory contains private information that shall not be added to the repository.

## Files

- `credentials.json`: Google Cloud credentials for the service account used by the application. Download this file from the Google Cloud Console.
- `vars.yml.j2`: Ansible vars that contain some private information. This file is a template that will generate the variables used in Ansible playbooks. Use the following snippet:
```yaml
## YOU MAY MODIFY THIS SECTION

# get the registration token by creating a GitLab runner in the repository
registration_token: #INSERT_HERE

# e.g. admin
db_user: #INSERT_HERE

# insert (any) password
db_password: #INSERT_HERE

# e.g: database
db_name: #INSERT_HERE


## DO NOT CHANGE THIS SECTION
rmcicd_int: ${ rmcicd_int }
```