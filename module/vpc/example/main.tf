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
    source = "../"
    name = "uptime-vpc-network"
    cred_path = "../../../service-account.json"
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