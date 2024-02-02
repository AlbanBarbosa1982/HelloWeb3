locals {
  project_id = "dotted-lens-412717"
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

variable "credentials_file" {
  description = "Path to the Google Cloud credentials file"
  type        = string
}

provider "google" {
  credentials = file(var.credentials_file)
  project     = local.project_id
  region      = local.region
}

provider "google-beta" {
  credentials = file(var.credentials_file)
  project     = local.project_id
  region      = local.region
}

data "google_project" "this" {}

data "google_compute_default_service_account" "default" {}
