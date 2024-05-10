resource "google_service_account" "sms" {
  account_id   = "sms-id"
  display_name = "sms-id Display Name"
}

resource "google_project_iam_member" "compute_role" {
  project = var.project
  role    = "roles/compute.instanceAdmin.v1"
  member  = "serviceAccount:${google_service_account.sms.email}"
}

###
resource "google_service_account" "gke-service-account" {
  account_id   = "gke-sa"
  display_name = "GKE Service Account"
}

resource "google_project_iam_binding" "gke-role-binding" {
  project = var.project

  for_each = toset([
    "roles/artifactregistry.reader",
    "roles/storage.objectViewer",
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/stackdriver.resourceMetadata.writer",
  ])
  role = each.key


  members = [
    "serviceAccount:${google_service_account.gke-service-account.email}",
  ]
}
###
