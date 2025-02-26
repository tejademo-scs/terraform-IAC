provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

resource "google_composer_environment" "composer_legacy" {
  name   = "my-composer-env"
  region = "us-central1"

  config {
    node_count = 3

    software_config {
      image_version = "composer-1.19.16-airflow-1.10.15"

      # Override Airflow configurations
      airflow_config_overrides = {
        "core.lazy_load_plugins"        = "False"
        "core.load_default_connections" = "False"
        "secrets.backend"               = "airflow.providers.google.cloud.secrets.secret_manager.CloudSecretManagerBackend"
        "secrets.backend_kwargs"        = <<EOT
          {
            "connections_prefix": "airflow-connections",
            "variables_prefix": "airflow-variables",
            "gcp_project_id": "your-gcp-project-id"
          }
        EOT
      }
    }

    node_config {
      service_account = "your-service-account@your-gcp-project-id.iam.gserviceaccount.com"
    }
  }
}
