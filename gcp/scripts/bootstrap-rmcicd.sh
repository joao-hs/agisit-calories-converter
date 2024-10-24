#!/bin/bash

apt-get update
apt-get -y upgrade

apt-get -y install ansible

apt-get -y install ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Download the binary for your system
curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64
# Give it permission to execute
chmod +x /usr/local/bin/gitlab-runner
# Create a GitLab Runner user
useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash

if ! getent group docker > /dev/null; then
    groupadd docker
fi
usermod -aG docker gitlab-runner

git lfs install --system

# Install and run as a service
gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
gitlab-runner start
gitlab-runner register  --url https://gitlab.rnl.tecnico.ulisboa.pt --executor shell --token $REGISTRATION_TOKEN --non-interactive
gitlab-runner restart

cp /home/rmcicd/ansible.cfg /home/gitlab-runner/ansible.cfg
cp /home/rmcicd/inventory.ini /home/gitlab-runner/inventory.ini

mkdir -p /home/gitlab-runner/.ssh
ssh-keygen -t rsa -b 2048 -f /home/gitlab-runner/.ssh/id_rsa_gl -N ""

sed -i 's/vagrant/gitlab-runner/g' /home/gitlab-runner/inventory.ini
sed -i 's/id_rsa/id_rsa_gl/g' /home/gitlab-runner/inventory.ini

mkdir -p /home/rmcicd/auth
# this registry is not exposed to the internet, so we can use (and expose) a simple password
docker run --entrypoint htpasswd httpd:2 -Bbn admin admin > /home/rmcicd/auth/htpasswd

mkdir -p /home/rmcicd/certs


INTERNAL_IP=$(hostname -I | grep -oP '10\.\d+\.\d+\.\d+')
cat <<EOF > /home/rmcicd/certs/san.cnf
[req]
default_bits       = 4096
default_md         = sha256
distinguished_name = req_distinguished_name
req_extensions     = req_ext
x509_extensions    = v3_req
prompt             = no

[req_distinguished_name]
C  = PT
ST = Lisbon
L  = Lisbon
O  = IST
OU = agisit24-g10
CN = rmcicd_int

[req_ext]
subjectAltName = @alt_names

[v3_req]
subjectAltName = @alt_names

[alt_names]
DNS.1 = rmcicd_int
DNS.2 = localhost
IP.1 = $INTERNAL_IP

EOF

openssl req -new -newkey rsa:4096 -out /home/rmcicd/certs/rmcicd.csr -keyout /home/rmcicd/certs/rmcicd.pem -nodes -config /home/rmcicd/certs/san.cnf
openssl x509 -req -in /home/rmcicd/certs/rmcicd.csr -CA /home/rmcicd/certs/ca.crt -CAkey /home/rmcicd/certs/ca.key -CAcreateserial -out /home/rmcicd/certs/rmcicd.crt -days 3650 -sha256

# openssl req -x509 -newkey rsa:4096 -keyout /home/rmcicd/certs/key.pem -out /home/rmcicd/certs/cert.pem -sha256 -days 3650 -nodes -config /home/rmcicd/san.cnf
