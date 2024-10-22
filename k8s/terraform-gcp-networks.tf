# Elemets of the cloud such as virtual servers,
# networks, firewall rules are created as resources
# syntax is: resource RESOURCE_TYPE RESOURCE_NAME
# https://www.terraform.io/docs/configuration/resources.html

resource "google_compute_firewall" "rules" {
  name    = "app-rules"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["53", "22", "80", "179", "443", "4789", "5000", "5432", "6443", "2379-2380", "30000-32767", "10250", "10251", "10252", "10255", "10256"]
  }

  allow {
    protocol = "udp"
    ports = ["53"]
  }

  priority = 500

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["master", "worker"]
}
