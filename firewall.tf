resource "google_compute_firewall" "allow_ssh_via_iap" {
  name      = "allow-ssh-via-iap"
  network   = google_compute_network.vpc_network.name
  direction = "INGRESS"
  priority  = "1000"
  allow {
    protocol = "TCP"
    ports    = ["22"]
  }
  source_ranges = ["35.235.240.0/20"]
}

resource "google_compute_firewall" "allow_private_dns" {
  name      = "allow-private-dns"
  network   = google_compute_network.vpc_network.name
  direction = "INGRESS"
  priority  = "1000"
  allow {
    protocol = "TCP"
    ports    = ["53"]
  }
  allow {
    protocol = "UDP"
    ports    = ["53"]
  }
  source_ranges = ["range/##"]
}

resource "google_compute_firewall" "allow_ping" {
  name      = "allow-ping"
  network   = google_compute_network.vpc_network.name
  direction = "INGRESS"
  priority  = "1000"
  allow {
    protocol = "icmp"
  }
  source_ranges = ["range/##"]
}

resource "google_compute_firewall" "allow-http" {
  name      = "allow-http"
  network   = google_compute_network.vpc_network.name
  direction = "INGRESS"
  priority  = "1000"
  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
  target_tags   = ["tag"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_foo" {
  name      = "allow-foo"
  network   = google_compute_network.vpc_network.name
  direction = "INGRESS"
  priority  = "1000"
  allow {
    protocol = "all"
  }
  source_ranges = ["range/##"]
}


resource "google_compute_firewall" "allow-rabbitmq-##" {
  name      = "allow-##"
  network   = google_compute_network.vpc_network.name
  direction = "INGRESS"
  priority  = "1000"
  allow {
    protocol = "tcp"
    ports    = ["##"]
  }
  target_tags   = ["tag"]
  source_ranges = ["range/##"]
}