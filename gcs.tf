resource "google_storage_bucket" "foo-bucket" {
  name                        = "foo_bucket"
  location                    = var.region.region1
  force_destroy               = true
  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }
}

resource "google_storage_bucket" "foo-terraform-state" {
  name                        = "foo-terraform-state"
  location                    = var.region.region1
  force_destroy               = true
  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }
}
