# How to define variables in terraform:
# https://www.terraform.io/docs/configuration/variables.html

# ID of the project, find it in the GCP console when clicking 
# on the project name (on the top dropdown)
variable "GCP_PROJECT_ID" {
  default = "agisit24-g10"
}

# A list of machine types is found at:
# https://cloud.google.com/compute/docs/machine-types
# prices are defined per region, before choosing an instance
# check the cost at: https://cloud.google.com/compute/pricing#machinetype
# Minimum required is N1 type = "n1-standard-1, 1 vCPU, 3.75 GB RAM"
variable "GCP_MACHINE_TYPE" {
  default = "n1-standard-1"
}

# Regions list is found at:
# https://cloud.google.com/compute/docs/regions-zones/regions-zones?hl=en_US
# For prices of your deployment check:
# Compute Engine dashboard -> VM instances -> Zone
variable "GCP_ZONE" {
  default = "europe-central2-a"
}

# Minimum required
variable "DISK_SIZE" {
  default = "15"
}

variable "IMAGE" {
  default = "projects/cos-cloud/global/images/family/cos-stable"
}

variable "FE_COUNT" {
  default = 1
}

variable "BE_CARBS_COUNT" {
  default = 1
}

variable "BE_DAIRY_COUNT" {
  default = 1
}

variable "BE_MEATS_COUNT" {
  default = 1
}

variable "BE_VEGETABLES_COUNT" {
  default = 1
}

variable "STORAGE_DEVICE_COUNT" {
  default = 1
}

variable "DB_COUNT" {
  default = 1
}
