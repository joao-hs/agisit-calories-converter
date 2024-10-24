# Elemets of the cloud such as virtual servers,
# networks, firewall rules are created as resources
# syntax is: resource RESOURCE_TYPE RESOURCE_NAME
# https://www.terraform.io/docs/configuration/resources.html

###########  Front-end   #############
# This method creates as many identical instances as the "count" index value
resource "google_compute_instance" "fe" {
  count = var.FE_COUNT
  name = "fe${count.index+1}"
  machine_type = var.GCP_MACHINE_TYPE
  zone = var.GCP_ZONE

  boot_disk {
      initialize_params {
      # image list can be found at:
      # https://console.cloud.google.com/compute/images
      image = var.IMAGE
      }
  }

  network_interface {
      network = "default"
      access_config {
      }
  }

  can_ip_forward = true

  metadata = {
    ssh-keys = "ubuntu:${file("/home/vagrant/.ssh/id_rsa.pub")}"
  }
  tags = ["fe"]
}


###########  Back-end Carbs   #############
# This method creates as many identical instances as the "count" index value
resource "google_compute_instance" "carbs" {
  count = var.BE_CARBS_COUNT
  name = "carbs${count.index+1}"
  machine_type = var.GCP_MACHINE_TYPE
  zone = var.GCP_ZONE

  boot_disk {
      initialize_params {
      # image list can be found at:
      # https://console.cloud.google.com/compute/images
      image = var.IMAGE
      }
  }

  network_interface {
      network = "default"
      access_config {
      }
  }

  metadata = {
    ssh-keys = "ubuntu:${file("/home/vagrant/.ssh/id_rsa.pub")}"
  }
  tags = ["carbs"]
}

###########  Back-end Dairy   #############
# This method creates as many identical instances as the "count" index value
resource "google_compute_instance" "dairy" {
  count = var.BE_DAIRY_COUNT
  name = "dairy${count.index+1}"
  machine_type = var.GCP_MACHINE_TYPE
  zone = var.GCP_ZONE

  boot_disk {
      initialize_params {
      # image list can be found at:
      # https://console.cloud.google.com/compute/images
      image = var.IMAGE
      }
  }

  network_interface {
      network = "default"
      access_config {
      }
  }

  metadata = {
    ssh-keys = "ubuntu:${file("/home/vagrant/.ssh/id_rsa.pub")}"
  }
  tags = ["dairy"]
}

###########  Back-end Meats   #############
# This method creates as many identical instances as the "count" index value
resource "google_compute_instance" "meats" {
  count = var.BE_MEATS_COUNT
  name = "meats${count.index+1}"
  machine_type = var.GCP_MACHINE_TYPE
  zone = var.GCP_ZONE

  boot_disk {
      initialize_params {
      # image list can be found at:
      # https://console.cloud.google.com/compute/images
      image = var.IMAGE
      }
  }

  network_interface {
      network = "default"
      access_config {
      }
  }

  metadata = {
    ssh-keys = "ubuntu:${file("/home/vagrant/.ssh/id_rsa.pub")}"
  }
  tags = ["meats"]
}


###########  Back-end Vegetables   #############
# This method creates as many identical instances as the "count" index value
resource "google_compute_instance" "vegetables" {
  count = var.BE_VEGETABLES_COUNT
  name = "vegetables${count.index+1}"
  machine_type = var.GCP_MACHINE_TYPE
  zone = var.GCP_ZONE

  boot_disk {
      initialize_params {
      # image list can be found at:
      # https://console.cloud.google.com/compute/images
      image = var.IMAGE
      }
  }

  network_interface {
      network = "default"
      access_config {
      }
  }

  metadata = {
    ssh-keys = "ubuntu:${file("/home/vagrant/.ssh/id_rsa.pub")}"
  }
  tags = ["vegetables"]
}

###########  Storage Device   #############
# This method creates as many identical instances as the "count" index value
resource "google_compute_instance" "storage" {
  count = var.STORAGE_DEVICE_COUNT
  name = "storage${count.index+1}"
  machine_type = var.GCP_MACHINE_TYPE
  zone = var.GCP_ZONE

  boot_disk {
      initialize_params {
      # image list can be found at:
      # https://console.cloud.google.com/compute/images
      image = var.IMAGE
      }
  }

  network_interface {
      network = "default"
      access_config {
      }
  }

  metadata = {
    ssh-keys = "ubuntu:${file("/home/vagrant/.ssh/id_rsa.pub")}"
  }
  tags = ["storage"]
}

###########  Database   #############
# This method creates as many identical instances as the "count" index value
resource "google_compute_instance" "db" {
  count = var.DB_COUNT
  name = "db${count.index+1}"
  machine_type = var.GCP_MACHINE_TYPE
  zone = var.GCP_ZONE

  boot_disk {
      initialize_params {
      # image list can be found at:
      # https://console.cloud.google.com/compute/images
      image = var.IMAGE
      }
  }

  network_interface {
      network = "default"
      access_config {
      }
  }

  metadata = {
    ssh-keys = "ubuntu:${file("/home/vagrant/.ssh/id_rsa.pub")}"
  }
  tags = ["db"]
}

###########  (R)egistry (M)onitor (CICD) runner   #############
resource "google_compute_instance" "rmcicd" {
  name = "rmcicd"
  machine_type = var.GCP_MACHINE_TYPE
  zone = var.GCP_ZONE

  boot_disk {
    initialize_params {
      image = "debian-12-bookworm-v20241009"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }

  metadata = {
    ssh-keys = "rmcicd:${file("/home/vagrant/.ssh/id_rsa.pub")}"
  }

  tags = ["rmcicd"]
}