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
    credentials = file("../../service-account.json")
    project = "mythic-music-377411"
    region = "asia-southeast2"
}

module "vpc" {
    source = "../../module/vpc"
    name = "uptime-vpc-network"
    cred_path = "../../service-account.json"
    project_id = "mythic-music-377411"
    region = "asia-southeast2"
    firewall_name = "uptime-vpc-firewall"

    source_ranges = [
        "0.0.0.0/0"
    ]
    allowed_tcp_ports = [
        "3000",
        "22"
    ]
    subnets = [
        {
            name = "uptime-public-subnet"
            ip_cidr_range = "10.0.0.0/10"
            region = "asia-southeast2"
        }
    ]
}

resource "google_compute_instance" "uptime" {
    name = "${var.uptime_vm_name}"
    machine_type = "${var.uptime_machine_type}"
    zone = "${var.uptime_vm_zone}"

    boot_disk {
        auto_delete = true
        initialize_params {
            image = "${var.uptime_vm_image}"
        }
    }

    network_interface {
        network = module.vpc.network_id
        subnetwork = module.vpc.subnetwork["uptime-public-subnet"].name
        access_config {}
    }

    tags = ["http-server", "https-server"]

    metadata = {
        enable-oslogin = "${var.uptime_metadata_oslogin}"
    }
}

output subnet {
    value = module.vpc.subnetwork["uptime-public-subnet"].ip_cidr_range
}

output vpc {
    value = module.vpc.network_id
}