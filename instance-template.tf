locals {
  foobar_subnets = {
    region1    = google_compute_subnetwork.region1_subnet.self_link
  }
}

## bar templates
resource "google_compute_instance_template" "foobar_bar_template" {
  for_each = var.foobar_configs.bar.regions

  name = format("%s-template", lookup(each.value, "name"))

  machine_type   = var.foobar_configs.bar.machine_type
  can_ip_forward = false

  scheduling {
    automatic_restart           = false
    provisioning_model          = "SPOT"
    preemptible                 = true
    instance_termination_action = "STOP"
  }

  // Create a new boot disk from an image
  disk {
    source_image = lookup(each.value, "machine_image")
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network    = google_compute_network.vpc_network.name
    subnetwork = lookup(local.foobar_subnets, each.key)
    access_config {
    }
  }

  metadata = {
    startup-script = file("${path.module}/templates/bar.tpl")
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}