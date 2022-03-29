data "terraform_remote_state" "vpcglobal" {
  backend = "gcs"
  config = {
    bucket = "terraform-project-team3"
    prefix = "terraform/state/vpcglobal"
  }
}
output "vpcglobal" {
  value = data.terraform_remote_state.vpcglobal.outputs.vpcglobal
}
output "project_id" {
  value = data.terraform_remote_state.vpcglobal.outputs.project_id
}

data "terraform_remote_state" "asg" {
  backend = "gcs"
  config = {
    bucket = "terraform-project-team3"
    prefix = "terraform/state/asg"
  }
}

resource "google_sql_database_instance" "db" {
  project             = data.terraform_remote_state.vpcglobal.outputs.project_id
  name                = var.name
  database_version    = var.database_version
  region              = var.region
  deletion_protection = var.deletion_protection

 settings {
    tier              = var.tier
    activation_policy = var.activation_policy
  }
}

resource "google_sql_user" "users" {
  name     = var.user_name
  instance = google_sql_database_instance.db.name
  host     = var.user_host
  password = var.user_password
}

resource "google_sql_database" "database" {
  name     = var.db_name
  instance = google_sql_database_instance.db.name
}

resource "google_compute_firewall" "allow-sql" {
  name    = "dbfirewall"
  network = data.terraform_remote_state.vpcglobal.outputs.vpcglobal
  allow {
    protocol = "tcp"
    ports    = ["3306"]
  }
  source_ranges = var.allowed_hosts
}
