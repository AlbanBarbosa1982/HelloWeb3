# IAM Role assignments for the existing Compute Engine default service account
resource "google_project_iam_member" "artifact_registry_writer" {
  project = "dotted-lens-412717"
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:213919970099-compute@developer.gserviceaccount.com"
}

resource "google_project_iam_member" "compute_network_admin" {
  project = "dotted-lens-412717"
  role    = "roles/compute.networkAdmin"
  member  = "serviceAccount:213919970099-compute@developer.gserviceaccount.com"
}

resource "google_project_iam_member" "kubernetes_engine_admin" {
  project = "dotted-lens-412717"
  role    = "roles/container.admin"
  member  = "serviceAccount:213919970099-compute@developer.gserviceaccount.com"
}

resource "google_project_iam_member" "service_account_user" {
  project = "dotted-lens-412717"
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:213919970099-compute@developer.gserviceaccount.com"
}

resource "google_project_iam_member" "storage_object_admin" {
  project = "dotted-lens-412717"
  role    = "roles/storage.objectAdmin"
  member  = "serviceAccount:213919970099-compute@developer.gserviceaccount.com"
}
