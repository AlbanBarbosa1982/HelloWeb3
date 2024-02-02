locals {
  project_id = "dotted-lens-412717"
  credentials = file("/Users/Alban/Werk/HelloWeb3/traffic-386513-0f741ebb862c.json")
  region     = "southamerica-east1"
  default_labels = {
    managed-by = "terraform"
  }
}

terraform {
  required_version = "~> 1.5"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.2"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 5.2"
    }
  }

  backend "gcs" {
    bucket = "lilteddybucketwhite"
  }
}

provider "google" {
  project = local.project_id
  region  = local.region
}

provider "google-beta" {
  project = local.project_id
  region  = local.region
}

data "google_project" "this" {}

data "google_compute_default_service_account" "default" {}
