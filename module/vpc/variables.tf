variable "cred_path" {
    description = "GCP service account for terraform"
    type = string
}

variable "project_id" {
    description = "The project will be use"
    type = string
}

variable "region" {
    description = "VPC region"
    type = string
}

variable "name" {
    description = "VPC name"
    type = string
}

variable "auto_create_subnetworks" {
    description = "Auto create subnetworks for all regions"
    type = bool
    default = false
}

variable "subnets" {
    description = "VPC subnetworks"
    type = list(object({
            name            = string
            ip_cidr_range   = string
            region          = string
    }))
    default = []
}

variable "firewall_name" {
    description = "Firewall name"
    type = string
}

variable "source_ranges" {
    description = "Allowed request sources ranges"
    type = list(string)
    default = []
}

variable "allowed_tcp_ports" {
    description = "Allowed tcp ports"
    type = list(string)
    default = ["22"]
}