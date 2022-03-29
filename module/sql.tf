module "sql" {
  source              = "../"
  name                = "db"
  database_version    = "MYSQL_5_7"
  region              = "us-central1"
  zone                = "us-central1-c"
  tier                = "db-n1-standard-1"
  activation_policy   = "ALWAYS"
  availability_type   = "REGIONAL"
  disk_size           = 10
  disk_type           = "PD_SSD"
  db_name             = "wordpress"
  user_name           = "admin"
  user_host           = "admin.com"
  user_password       = "changeme"
  deletion_protection = false
  allowed_hosts       = ["34.134.197.21"]
}



