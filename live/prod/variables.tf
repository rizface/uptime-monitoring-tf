variable "uptime_vm_name" {
    description = "vm name"
    type = string
    default = "uptime-vm"
}

variable "uptime_vm_image" {
    description = "vm image"
    type = string
    default = "debian-cloud/debian-12"
}

variable "uptime_machine_type" {
    description = "vm machine type"
    type = string
    default = "e2-medium"
}

variable "uptime_vm_zone" {
    description = "vm zone"
    type = string
    default = "asia-southeast2-a"
}

variable "uptime_metadata_oslogin" {
    description = "vm metadata to allow ssh using oslogin"
    type = string
    default = "TRUE"
}