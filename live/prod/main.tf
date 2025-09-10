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
        network = "default"
        access_config {}
    }

    tags = ["http-server", "https-server"]

    metadata = {
        enable-oslogin = "${var.uptime_metadata_oslogin}"
    }
}