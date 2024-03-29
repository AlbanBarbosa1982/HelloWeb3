locals {
  project_id = "dotted-lens-412717"
  region     = "europe-west1"
  zone       = "europe-west1-d"
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
