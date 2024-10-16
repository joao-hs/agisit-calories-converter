# Terraform GCP
# To output variables, follow pattern:
# value = TYPE.NAME.ATTR

output "master_IPs" {
    value = formatlist("%s = %s", google_compute_instance.master[*].name, google_compute_instance.master[*].network_interface.0.access_config.0.nat_ip)
}

output "master_ssh" {
 value = formatlist("%s = %s", google_compute_instance.master[*].name, google_compute_instance.master[*].self_link)
}

# example for a set of identical instances created with "count"
output "worker_IPs"  {
  value = formatlist("%s = %s", google_compute_instance.worker[*].name, google_compute_instance.worker[*].network_interface.0.access_config.0.nat_ip)
}

output "worker_ssh" {
 value = formatlist("%s = %s", google_compute_instance.worker[*].name, google_compute_instance.worker[*].self_link)
}

# Populate the IPs to the inventory file
locals {
  masters_ids = google_compute_instance.master[*].name
  masters_ips = google_compute_instance.master[*].network_interface.0.access_config.0.nat_ip
  workers_ids = google_compute_instance.worker[*].name
  workers_ips = google_compute_instance.worker[*].network_interface.0.access_config.0.nat_ip
  masters_inventory = zipmap(local.masters_ids, local.masters_ips)
  workers_inventory = zipmap(local.workers_ids, local.workers_ips)

  inventory_content = templatefile("${path.module}/templates/inventory.ini.j2", {
    masters = [for worker_id, worker_ip in local.masters_inventory : {
      id = worker_id
      ip = worker_ip
    }],
    workers = [for worker_id, worker_ip in local.workers_inventory : {
      id = worker_id
      ip = worker_ip
    }]
  })
}

# Write to inventory file
resource "local_file" "ansible_inventory" {
  content  = local.inventory_content
  filename = "${path.module}/inventory.ini"
}
