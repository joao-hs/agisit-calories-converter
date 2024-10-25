### Config files to be used in deployment

There is no needed action here.

- `ca.cnf`: Configuration to create a certificate for the self-signed "Certificate Authority" in a non-interactive way.
- `prometheus.yml.j2`: Template to define Prometheus targets. The values are filled by Terraform. The resulting file will be in `generated/prometheus.yml`