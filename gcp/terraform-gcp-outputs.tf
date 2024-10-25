# Terraform GCP
# To output variables, follow pattern:
# value = TYPE.NAME.ATTR

output "rmcicd_ext_IP" {
  value = google_compute_instance.rmcicd.network_interface.0.access_config.0.nat_ip
}

output "rmcicd_int_IP" {
  value = google_compute_instance.rmcicd.network_interface.0.network_ip
}

output "rmcicd_ssh" {
  value = google_compute_instance.rmcicd.self_link
}

output "fe_ext_IPs" {
  value = formatlist("%s = %s", google_compute_instance.fe[*].name, google_compute_instance.fe[*].network_interface.0.access_config.0.nat_ip)
}

output "fe_int_IPs" {
  value = formatlist("%s = %s", google_compute_instance.fe[*].name, google_compute_instance.fe[*].network_interface.0.network_ip)
}

output "fe_ssh" {
  value = formatlist("%s = %s", google_compute_instance.fe[*].name, google_compute_instance.fe[*].self_link)
}

output "carbs_ext_IPs" {
  value = formatlist("%s = %s", google_compute_instance.carbs[*].name, google_compute_instance.carbs[*].network_interface.0.access_config.0.nat_ip)
}

output "carbs_int_IPs" {
  value = formatlist("%s = %s", google_compute_instance.carbs[*].name, google_compute_instance.carbs[*].network_interface.0.network_ip)
}

output "carbs_ssh" {
  value = formatlist("%s = %s", google_compute_instance.carbs[*].name, google_compute_instance.carbs[*].self_link)
}

output "dairy_ext_IPs" {
  value = formatlist("%s = %s", google_compute_instance.dairy[*].name, google_compute_instance.dairy[*].network_interface.0.access_config.0.nat_ip)
}

output "dairy_int_IPs" {
  value = formatlist("%s = %s", google_compute_instance.dairy[*].name, google_compute_instance.dairy[*].network_interface.0.network_ip)
}

output "dairy_ssh" {
  value = formatlist("%s = %s", google_compute_instance.dairy[*].name, google_compute_instance.dairy[*].self_link)
}

output "meats_ext_IPs" {
  value = formatlist("%s = %s", google_compute_instance.meats[*].name, google_compute_instance.meats[*].network_interface.0.access_config.0.nat_ip)
}

output "meats_int_IPs" {
  value = formatlist("%s = %s", google_compute_instance.meats[*].name, google_compute_instance.meats[*].network_interface.0.network_ip)
}

output "meats_ssh" {
  value = formatlist("%s = %s", google_compute_instance.meats[*].name, google_compute_instance.meats[*].self_link)
}

output "vegetables_ext_IPs" {
  value = formatlist("%s = %s", google_compute_instance.vegetables[*].name, google_compute_instance.vegetables[*].network_interface.0.access_config.0.nat_ip)
}

output "vegetables_int_IPs" {
  value = formatlist("%s = %s", google_compute_instance.vegetables[*].name, google_compute_instance.vegetables[*].network_interface.0.network_ip)
}

output "vegetables_ssh" {
  value = formatlist("%s = %s", google_compute_instance.vegetables[*].name, google_compute_instance.vegetables[*].self_link)
}

output "storage_ext_IPs" {
  value = formatlist("%s = %s", google_compute_instance.storage[*].name, google_compute_instance.storage[*].network_interface.0.access_config.0.nat_ip)
}

output "storage_int_IPs" {
  value = formatlist("%s = %s", google_compute_instance.storage[*].name, google_compute_instance.storage[*].network_interface.0.network_ip)
}

output "storage_ssh" {
  value = formatlist("%s = %s", google_compute_instance.storage[*].name, google_compute_instance.storage[*].self_link)
}

output "db_ext_IPs" {
  value = formatlist("%s = %s", google_compute_instance.db[*].name, google_compute_instance.db[*].network_interface.0.access_config.0.nat_ip)
}

output "db_int_IPs" {
  value = formatlist("%s = %s", google_compute_instance.db[*].name, google_compute_instance.db[*].network_interface.0.network_ip)
}

output "db_ssh" {
  value = formatlist("%s = %s", google_compute_instance.db[*].name, google_compute_instance.db[*].self_link)
}

# Populate the IPs to the inventory file
locals {
  fe_ids             = google_compute_instance.fe[*].name
  fe_ext_ips         = google_compute_instance.fe[*].network_interface.0.access_config.0.nat_ip
  fe_int_ips         = google_compute_instance.fe[*].network_interface.0.network_ip
  carbs_ids          = google_compute_instance.carbs[*].name
  carbs_ext_ips      = google_compute_instance.carbs[*].network_interface.0.access_config.0.nat_ip
  carbs_int_ips      = google_compute_instance.carbs[*].network_interface.0.network_ip
  dairy_ids          = google_compute_instance.dairy[*].name
  dairy_ext_ips      = google_compute_instance.dairy[*].network_interface.0.access_config.0.nat_ip
  dairy_int_ips      = google_compute_instance.dairy[*].network_interface.0.network_ip
  meats_ids          = google_compute_instance.meats[*].name
  meats_ext_ips      = google_compute_instance.meats[*].network_interface.0.access_config.0.nat_ip
  meats_int_ips      = google_compute_instance.meats[*].network_interface.0.network_ip
  vegetables_ids     = google_compute_instance.vegetables[*].name
  vegetables_ext_ips = google_compute_instance.vegetables[*].network_interface.0.access_config.0.nat_ip
  vegetables_int_ips = google_compute_instance.vegetables[*].network_interface.0.network_ip
  storage_ids        = google_compute_instance.storage[*].name
  storage_ext_ips    = google_compute_instance.storage[*].network_interface.0.access_config.0.nat_ip
  storage_int_ips    = google_compute_instance.storage[*].network_interface.0.network_ip
  db_ids             = google_compute_instance.db[*].name
  db_ext_ips         = google_compute_instance.db[*].network_interface.0.access_config.0.nat_ip
  db_int_ips         = google_compute_instance.db[*].network_interface.0.network_ip

  fe_ext_inventory         = zipmap(local.fe_ids, local.fe_ext_ips)
  fe_int_inventory         = zipmap(local.fe_ids, local.fe_int_ips)
  carbs_ext_inventory      = zipmap(local.carbs_ids, local.carbs_ext_ips)
  carbs_int_inventory      = zipmap(local.carbs_ids, local.carbs_int_ips)
  dairy_ext_inventory      = zipmap(local.dairy_ids, local.dairy_ext_ips)
  dairy_int_inventory      = zipmap(local.dairy_ids, local.dairy_int_ips)
  meats_ext_inventory      = zipmap(local.meats_ids, local.meats_ext_ips)
  meats_int_inventory      = zipmap(local.meats_ids, local.meats_int_ips)
  vegetables_ext_inventory = zipmap(local.vegetables_ids, local.vegetables_ext_ips)
  vegetables_int_inventory = zipmap(local.vegetables_ids, local.vegetables_int_ips)
  storage_ext_inventory    = zipmap(local.storage_ids, local.storage_ext_ips)
  storage_int_inventory    = zipmap(local.storage_ids, local.storage_int_ips)
  db_ext_inventory         = zipmap(local.db_ids, local.db_ext_ips)
  db_int_inventory         = zipmap(local.db_ids, local.db_int_ips)

  inventory_content = templatefile("${path.module}/templates/inventory.ini.j2", {
    rmcicd = {
      ext_ip = google_compute_instance.rmcicd.network_interface.0.access_config.0.nat_ip
      int_ip = google_compute_instance.rmcicd.network_interface.0.network_ip
    }

    fe_ext = [for instance_id, ext_ip in local.fe_ext_inventory : {
      id = instance_id
      ip = ext_ip
    }],

    fe_int = [for instance_id, int_ip in local.fe_int_inventory : {
      id = instance_id
      ip = int_ip
    }],

    carbs_ext = [for instance_id, ext_ip in local.carbs_ext_inventory : {
      id = instance_id
      ip = ext_ip
    }],

    carbs_int = [for instance_id, int_ip in local.carbs_int_inventory : {
      id = instance_id
      ip = int_ip
    }],

    dairy_ext = [for instance_id, ext_ip in local.dairy_ext_inventory : {
      id = instance_id
      ip = ext_ip
    }],

    dairy_int = [for instance_id, int_ip in local.dairy_int_inventory : {
      id = instance_id
      ip = int_ip
    }],

    meats_ext = [for instance_id, ext_ip in local.meats_ext_inventory : {
      id = instance_id
      ip = ext_ip
    }],

    meats_int = [for instance_id, int_ip in local.meats_int_inventory : {
      id = instance_id
      ip = int_ip
    }],

    vegetables_ext = [for instance_id, ext_ip in local.vegetables_ext_inventory : {
      id = instance_id
      ip = ext_ip
    }],

    vegetables_int = [for instance_id, int_ip in local.vegetables_int_inventory : {
      id = instance_id
      ip = int_ip
    }],

    storage_ext = [for instance_id, ext_ip in local.storage_ext_inventory : {
      id = instance_id
      ip = ext_ip
    }],

    storage_int = [for instance_id, int_ip in local.storage_int_inventory : {
      id = instance_id
      ip = int_ip
    }],

    db_ext = [for instance_id, ext_ip in local.db_ext_inventory : {
      id = instance_id
      ip = ext_ip
    }],

    db_int = [for instance_id, int_ip in local.db_int_inventory : {
      id = instance_id
      ip = int_ip
    }]
  })

  vars_content = templatefile("${path.module}/secrets/vars.yml.j2", {
    rmcicd_int = google_compute_instance.rmcicd.network_interface.0.network_ip
  })

  prometheus_config_content = templatefile("${path.module}/config-files/prometheus.yml.j2", {
    fe_int = local.fe_int_ips,
    carbs_int = local.carbs_int_ips,
    dairy_int = local.dairy_int_ips,
    meats_int = local.meats_int_ips,
    vegetables_int = local.vegetables_int_ips,
    storage_int = local.storage_int_ips,
    db_int = local.db_int_ips,
  })
}

# Write to inventory file
resource "local_file" "ansible_inventory" {
  content  = local.inventory_content
  filename = "${path.module}/inventory.ini"
}

resource "local_file" "ansible_vars" {
  content = local.vars_content
  filename = "${path.module}/vars.yml"
}

resource "local_file" "prometheus_config" {
  content = local.prometheus_config_content
  filename = "${path.module}/config-files/generated/prometheus.yml"
}
