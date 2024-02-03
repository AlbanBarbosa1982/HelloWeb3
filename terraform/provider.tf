locals {
  project_id = "traffic-386513"
  region     = "europe-west1"
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
