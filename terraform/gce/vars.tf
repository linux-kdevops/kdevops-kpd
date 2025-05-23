variable "gce_credentials" {
  description = "Path to the your service account JSON credentials file"
  type        = string
}

variable "gce_disk_count" {
  description = "Count of attached disks per instance"
  type        = number
}

variable "gce_disk_iops" {
  description = "Provisioned IOPS for each attached disk"
  type        = number
  default     = null
}

variable "gce_disk_size" {
  description = "Size of each attached disk, in GB"
  type        = number
}

variable "gce_disk_throughput" {
  description = "Provisioned throughput for each attached disk"
  type        = number
  default     = null
}

variable "gce_disk_type" {
  description = "Performance class of attached disks"
  type        = string
}

variable "gce_image_family" {
  description = "Release of Linux distribution"
  type        = string
}

variable "gce_image_project" {
  description = "Name of Linux distribution"
  type        = string
}

variable "gce_image_size" {
  description = "Size of image, in GiB"
  type        = number
}

variable "gce_image_type" {
  description = "Type of image disk"
  type        = string
}

variable "gce_machine_type" {
  description = "Machine type"
  type        = string
}

variable "gce_project" {
  description = "Your project name"
  type        = string
}

variable "gce_region" {
  description = "Geographic Region"
  type        = string
}

variable "gce_zone" {
  description = "Availability zone"
  type        = string
}
