provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

resource "google_secret_manager_secret" "test_secret" {
  secret_id = "lts-encrtypt"

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "example_secret_version" {
  secret      = google_secret_manager_secret.example_secret.id
  secret_data = "my-secret-value"
}

resource "google_secret_manager_secret_iam_member" "example" {
  secret_id = google_secret_manager_secret.test_secret.id
  role      = "roles/secretmanager.secretAccessor"
  member    = "user:your-email@example.com"
}
