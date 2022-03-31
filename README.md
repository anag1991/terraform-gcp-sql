# Terraform GCP SQL
> Use Terraform to create a database on Google Cloud Platform (GCP)

## Table of Contents
* [Prerequisites](#prerequisites)
* [Providers](#providers)
* [Features](#features)
* [Usage](#usage)
* [Examples](#examples)
* [Inputs](#inputs)
* [Outputs](#outputs)
* [Resources](#resources)

## Prerequisites
 Active account on Google Cloud Platform with: 
* Active Billing Account enabled
* Active Project Account

## Providers

| Name | Version |
| ----------- | ----------- |
| Terraform | v1.1.7 |
| Google Cloud SDK | 378.0.0 |

## Features
### Fully managed
Cloud SQL automatically ensures your databases are reliable, secure, and scalable so that your business continues to run without disruption. Cloud SQL automates all your backups, replication, encryption patches, and capacity increases—while ensuring greater than 99.95% availability, anywhere in the world.

### Integrated
Access Cloud SQL instances from just about any application. Easily connect from App Engine, Compute Engine, Google Kubernetes Engine, and your workstation. Open up analytics possibilities by using BigQuery to directly query your Cloud SQL databases.

### Reliable
Easily configure replication and backups to protect your data. Go further by enabling automatic failover to make your database highly available. Your data is automatically encrypted, and Cloud SQL is SSAE 16, ISO 27001, and PCI DSS compliant and supports HIPAA compliance.

## Usage
Login to your google console. Activate your cloudshell editor. Git clone the repository. Edit any variables to meet your specific needs. Set your project by running "gcloud config set project [PROJECT_ID]" 

run: terraform init && terraform plan && terraform apply -auto-approve
```
resource "google_sql_database_instance" "projectx" {
  project             = var.project_id
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
  instance = google_sql_database_instance.projectx.name
  host     = var.user_host
  password = var.user_password
}

resource "google_sql_database" "database" {
  name     = var.db_name
  instance = google_sql_database_instance.projectx.name
}

resource "google_compute_firewall" "allow-sql" {
  name    = var.vm_config["firewall_name"]
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["3306"]
  }
  source_tags = [var.vm_config["network_tags"]]
}
```
### Login to SQL
* You can connect to your db instance from Cloud Shell by using the following command: `gcloud sql connect projectx --user=admin --quiet`  and the default password set = `changeme`
* You can also configure a `private IP` to use with your own VPC

## Examples
![db example](https://files.slack.com/files-pri/T036RBNDWKH-F03900LN6TZ/image.png)

![firewall example](https://files.slack.com/files-pri/T036RBNDWKH-F0397U682FQ/image.png)

## Inputs
| Name | Description | Type | Required | Default |
| --- | ----------- | --- | ----------- |----------- |
| activation_policy | The activation policy for the master instance. Can be either `ALWAYS`, `NEVER` or `ON_DEMAND` | string | No | `ALWAYS` |
| availability_type | The availability type for the master instance. Can be either `REGIONAL` or `null` | string | No |  `REGIONAL` |
| database_version | The database version to use | string | Yes | MYSQL_5_7 |
| db_name | The name of the default database to create | string | Yes | wordpress |
| deletion_protection | Used to block Terraform from deleting a SQL Instance. | bool| No | false |
| disk_size | The disk size for the master instance |number | No | 10 |
| disk_type | The disk type for the master instance. | string | No | PD_SSD |
|name | The name of the Cloud SQL resources| string | Yes | projectx |
| project_id | The project ID to manage the Cloud SQL resources | string | No | oizududusloekcuq |
| region | The region of the Cloud SQL resources | string | No | us-central1 |
| tier | The tier for the master instance. | string | Yes | db-n1-standard-1 |
| user_host | The host for the default user | string | No | admin.com |
| user_name | The name of the default user |string | No | admin |
| user_password | The password for the default user. If not set, a random one will be generated and available in the generated_user_password output variable | string | No | changeme |
| zone | The zone for the master instance, it should be something like: `us-central1-a`, `us-east1-c`. | string | No | us-central1-c |


## Outputs
| Output      | Title | Description |
| ----------- | ----------- | ----------- |
| google_sql_database_instance.projectx.connection_name      | instance_connection_name       | The connection name of the master instance to be used in connection strings   | 
| google_sql_database_instance.projectx.first_ip_address     | instance_first_ip_address     | The first IPv4 address of the addresses assigned for the master instance| 
| google_sql_database_instance.projectx.ip_address      | instance_ip_address    | The IPv4 address assigned for the master instance   | 
|google_sql_database_instance.projectx.name      |instance_name       | The instance name for the master instance |
| google_sql_database_instance.projectx.private_ip_address     | private_address      | The private IP address assigned for the master instance  | 
|google_sql_database_instance.projectx.self_link     |instance_self_link      |The URI of the master instance   | 

## Resources
* https://registry.terraform.io/providers/hashicorp/google/latest/docs
* https://cloud.google.com/sql/docs

