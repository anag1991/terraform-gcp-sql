output "instance_name" {
  value       = google_sql_database_instance.cloud-sql.name
  description = "The instance name for the master instance"
}

output "instance_ip_address" {
  value       = google_sql_database_instance.cloud-sql.ip_address
  description = "The IPv4 address assigned for the master instance"
}

output "private_address" {
  value       = google_sql_database_instance.cloud-sql.private_ip_address
  description = "The private IP address assigned for the master instance"
}

output "instance_first_ip_address" {
  value       = google_sql_database_instance.cloud-sql.first_ip_address
  description = "The first IPv4 address of the addresses assigned for the master instance."
}

output "instance_connection_name" {
  value       = google_sql_database_instance.cloud-sql.connection_name
  description = "The connection name of the master instance to be used in connection strings"
}

output "instance_self_link" {
  value       = google_sql_database_instance.cloud-sql.self_link
  description = "The URI of the master instance"
}
