terraform {
    required_version = ">= 1.13.1"
    required_providers {
        google = {
            source = "hashicorp/google"
            version = ">= 7.1.1"
        }
    }   
}

provider google {
    credentials = file("${var.cred_path}")
    project = "${var.project_id}"
    region = "${var.region}"
}

resource "google_compute_network" "uptime-vpc-network" {
    name = "${var.name}"
    project = "${var.project_id}"
    auto_create_subnetworks = var.auto_create_subnetworks
}

resource "google_compute_subnetwork" "uptime-public-subnet" {
    for_each = { for s in var.subnets : s.name => s }

    name = each.value.name
    ip_cidr_range = each.value.ip_cidr_range
    region = each.value.region
    network = google_compute_network.uptime-vpc-network.id
}

resource "google_compute_firewall" "uptime-firewall" {
    name = "${var.firewall_name}"
    project = "${var.project_id}"
    network = google_compute_network.uptime-vpc-network.id
    source_ranges = var.source_ranges

    allow {
        protocol = "tcp"
        ports = var.allowed_tcp_ports
    }
}