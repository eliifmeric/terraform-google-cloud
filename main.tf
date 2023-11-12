provider "google" {
    project = "terraform-403719"
    credentials = file("terraform-403719-0f40ee6048e8.json")
    region = "us-central1"
    zone = "us-central1-a"
}

resource "google_compute_instance" "my_instance" {
    name = "terraform-instance"
    machine_type = "n2-standard-2"
    zone = "us-central1-a"
    allow_stopping_for_update = true

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-11"
        }
    }

    network_interface {
        network = google_compute_network.terraform_network.self_link
        subnetwork = google_compute_subnetwork.terraform_subnet.self_link
        access_config {
            //necessary even empty
        }
    }
}

resource "google_compute_network" "terraform_network" {
    name = "terraform-network"
    auto_create_subnetworks = false
    }

resource "google_compute_subnetwork" "terraform_subnet" {
    name = "terraform-subnetwork"
    ip_cidr_range = "10.20.0.0/16"
    region = "us-central1"
    network = google_compute_network.terraform_network.id
}
