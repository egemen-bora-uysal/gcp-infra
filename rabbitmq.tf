locals {
  bar_tag = {

    name = "rabbitmq-bar"
    dns  = "bar-mq.${google_dns_managed_zone.foo_int.dns_name}"

    local_ip     = "range/##"
    machine_type = "machine-type"
    zone         = var.zones.region1[0]
    tag          = "tag"
  }
}


# Rabbitmq external ip
resource "google_compute_address" "rabbitmq_bar_external" {
  name   = "rabbitmq-bar-external"
  region = var.region.region1
}

# Rabbitmq internal ip
resource "google_compute_address" "rabbitmq_bar_internal" {
  name         = "rabbitmq-bar-internal"
  address_type = "INTERNAL"
  address      = local.bar_tag.local_ip
  subnetwork   = google_compute_subnetwork.region1_subnet.id
  region       = var.region.region1
}

# Rabbitmq DNS A Record
resource "google_dns_record_set" "rabbitmq_bar_record" {
  name = local.bar_tag.dns
  type = "A"
  ttl  = 0

  managed_zone = google_dns_managed_zone.foo_int.name

  # Private IP of the instance
  rrdatas = [local.bar_tag.local_ip]
}

# Rabbitmq instance
resource "google_compute_instance" "rabbitmq_main" {
  name           = local.bar_tag.name
  machine_type   = local.bar_tag.machine_type
  zone           = local.bar_tag.zone
  desired_status = "RUNNING"

  tags = [
    local.bar_tag.tag
  ]

  boot_disk {
    initialize_params {
      type  = "pd-standard"
      size  = 100
      image = "image"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.region1_subnet.self_link
    network_ip = google_compute_address.rabbitmq_bar_internal.address
    access_config {
      nat_ip = google_compute_address.rabbitmq_bar_external.address
    }
  }

  service_account {
    scopes = ["cloud-platform"]
  }

  scheduling {
    preemptible       = false
    automatic_restart = true
  }
}
