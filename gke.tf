###
module "kubernetes-engine_private-cluster" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version = "~> 24.1"

  name               = var.cluster_name
  project_id         = var.project
  network_project_id = var.project
  regional           = false
  zones              = [var.zones.region1[0]]

  network                 = google_compute_network.vpc_network.name
  subnetwork              = google_compute_subnetwork.gke_subnet.name
  ip_range_pods           = var.ip_range_pods
  ip_range_services       = var.ip_range_services
  master_ipv4_cidr_block  = var.master_ip_range
  create_service_account  = false
  service_account         = google_service_account.gke-service-account.email
  grant_registry_access   = true
  release_channel         = "STABLE"
  enable_private_nodes    = true
  enable_private_endpoint = false


  remove_default_node_pool  = true
  default_max_pods_per_node = "32"
  datapath_provider         = "ADVANCED_DATAPATH"

  # ### maintanance time
  # maintenance_start_time = var.maintenance_start_time
  # maintenance_end_time   = var.maintenance_end_time
  # maintenance_recurrence = var.maintenance_recurrence

  node_pools = [
    {
      name           = var.node_pool_name
      image_type     = "ubuntu_containerd"
      node_locations = var.zones.region1[0]
      spot           = "true"
      disk_size_gb   = 40
      machine_type   = "machine-type"
      auto_upgrade   = true
      auto_repair    = true

      # [AUTOSCALING ENABLED]
      initial_node_count = 1
      min_count          = 1
      max_count          = 3

      # [AUTOSCALING DISABLED]
      # node_count  = 2
      # autoscaling = false



    },
  ]

  node_pools_tags = {
    "${var.node_pool_name}" : [
      "foo-gke-node-pool"
    ]
  }

  node_pools_metadata = {
    all = {
      disable_legacy_metadata_endpoints = true
    }
  }

}
###