provider "google" {
project = var.project_id
region = var.region
}
//VPC
resource  "google_compute_network" "poc" {
name = "vpc-1"
auto_create_subnetworks = false
}
//Sub Network
resource  "google_compute_subnetwork" "sub-1" {
name = var.sub
region = var.region
ip_cidr_range = var.ip_cidr
network = google_compute_network .poc.name
}
//Firewall
resource  "google_compute_firewall"  "firewall-1" {
name = var.firewall
network = google_compute_network.poc.name
allow {
protocol =  "icmp"
}
allow {
protocol = "tcp"
ports = ["80","8080","22"]
}
source_tags = ["poc-vpc-ssh"]
source_ranges = ["0.0.0.0/0"]
}
// Service Account
resource "google_service_account" "terraform" {
account_id = "serviceaccountid"
display_name = "Service_account"
}
// VM Instance
resource "google_compute_instance" "vpc-1" {
name = "vpc-1"
machine_type = var.machine_type
zone = var.zone
tags = ["poc-vpc-1-ssh","http","https"]
boot_disk {
initialize_params {
  image = var.rom
}
}
network_interface {
network    = google_compute_network.poc.name
subnetwork = google_compute_subnetwork.sub-1.name
access_config {
 }
 }
metadata ={ 
    ssh-keys = "${var.user}:${file("${var.ssh_public_key}")}"
}
 provisioner "remote-exec" {
    inline = ["echo 'Hello World'"]

    connection {
      host        = "${google_compute_instance.vpc-1.network_interface.0.access_config.0.nat_ip}"
      type        = "ssh"
      user        = "${var.user}"
      private_key = "${file("${var.ssh_private_key}")}"
    }
  }
provisioner "local-exec" {
    command = "ansible-playbook  -i '${google_compute_instance.vpc-1.network_interface.0.access_config.0.nat_ip},' --private-key ${var.ssh_private_key} ansible.yml"
}
service_account {
email = google_service_account.terraform.email
scopes = ["cloud-platform"]
}
}


