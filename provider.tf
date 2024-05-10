terraform {
  required_version = "~> 1.3.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.24"
    }
    ###
    kubernetes = {
      version = "~> 2.16"
      source  = "hashicorp/kubernetes"
    }
    ###
  }

  backend "gcs" {
    bucket = "foo-terraform-state"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.project
}

