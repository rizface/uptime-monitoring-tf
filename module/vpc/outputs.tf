output "network_id" {
    description = "VPC id"
    value = google_compute_network.uptime-vpc-network.name
}

output "subnetwork" {
    value = google_compute_subnetwork.uptime-public-subnet
}