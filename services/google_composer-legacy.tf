resource "google_composer_environment" "example" {
  name   = "example-composer-env"
  region = "us-central1"

  config {
    software_config {
      airflow_config_overrides = {
        webserver-dag_default_view         = "graph"
        core-dagbag_import_timeout         = "240"
        core-dags_are_paused_at_creation   = "True"
        scheduler-catchup_by_default       = "False"
        webserver-scheduler_zombie_task_threshold = "50"
        webserver-worker_refresh_interval  = "30"
        webserver-rbac_user_registration_role = "Viewer"
        secrets-backend = "airflow.providers.google.cloud.secrets.secret_manager.CloudSecretManagerBackend"
        secrets-backend_kwargs = <<EOT
        {
          "connections_prefix": "${coalesce(var.secret_conn_prefix, "airflow-connections-${var.cmpsr_name}-${each.key}")}",
          "variables_prefix": "${coalesce(var.secret_var_prefix, "airflow-variables-${var.cmpsr_name}-${each.key}")}"
        }
        EOT
      }

      image_version = try(var.env_overrides[each.key].image_version, var.image_version)
    }
  }

  lifecycle {
    ignore_changes = [
      config[0].software_config[0].airflow_config_overrides,
      config[0].software_config[0].env_variables,
      config[0].software_config[0].pypi_packages
    ]
  }

  depends_on = [google_project_iam_member.composer2_svcagent_iam]
}
