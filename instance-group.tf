## BAR MIG
resource "google_compute_region_instance_group_manager" "foobar_bar_mig" {
  for_each = var.foobar_configs.bar.regions

  name = format("%s-mig", lookup(each.value, "name"))

  base_instance_name        = lookup(each.value, "name")
  region                    = var.region[each.key]
  distribution_policy_zones = var.zones[each.key]

  version {
    instance_template = google_compute_instance_template.foobar_bar_template[each.key].self_link
  }
  # target_size = lookup(each.value, "count")
  target_size = 0

  lifecycle {
    ignore_changes = [
      target_size
    ]
  }
}