resource "google_compute_network" "vpc_network" {
  project                 = var.project
  name                    = format("%s-network", var.project)
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "region1_subnet" {
  name          = format("%s-%s", var.project, var.region.region1)
  ip_cidr_range = var.subnets.region1
  region        = var.region.region1
  network       = google_compute_network.vpc_network.name
}

###
resource "google_compute_subnetwork" "gke_subnet" {
  name                     = format("%s-%s", var.project, var.region.region1)
  ip_cidr_range            = var.subnets.gke
  region                   = var.region.region1
  network                  = google_compute_network.vpc_network.name
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = var.ip_range_pods
    ip_cidr_range = var.subnet_pod_ip_range
  }

  secondary_ip_range {
    range_name    = var.ip_range_services
    ip_cidr_range = var.subnet_svc_ip_range
  }
}
###
