resource "google_dns_managed_zone" "foo_int" {
  name       = "foo-int"
  dns_name   = "foo.int."
  visibility = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.vpc_network.id
    }
  }
}
