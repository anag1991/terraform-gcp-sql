# Terraform GCP SQL
> Use Terraform to create a database on Google Cloud Platform (GCP)

## Table of Contents
* [General Info](#general-information)
* [Providers](#providers)
* [Features](#features)
* [Screenshots](#screenshots)
* [Setup](#setup)
* [Usage](#usage)
* [Inputs](#inputs)
* [Outputs](#outputs)
* [Examples](#examples)
* [Acknowledgements](#acknowledgements)
* [Contact](#contact)

## General Information
- This repo was created specifically to create a CloudSql to use with wordpress autoscaling group. 
- When used on it's own it will create a database with user name and password. 

## Providers

| Name | Version |
| ----------- | ----------- |
| Terraform | v1.1.7 |
| Google Cloud SDK | 378.0.0 |



## Features
List the ready features here:
- Awesome feature 1
- Awesome feature 2
- Awesome feature 3

## Screenshots
![Example screenshot](./img/screenshot.png)
<!-- If you have screenshots you'd like to share, include them here. -->

## Setup
What are the project requirements/dependencies? Where are they listed? A requirements.txt or a Pipfile.lock file perhaps? Where is it located?
Proceed to describe how to install / setup one's local environment / get started with the project.

## Usage
How does one go about using it?
Provide various use cases and code examples here.
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

## Inputs
| Name | Description | Type | Required | Default |
| --- | ----------- | --- | ----------- |----------- |
| activation_policy | The activation policy for the master instance. Can be either `ALWAYS`, `NEVER` or `ON_DEMAND` | string | Title | `ALWAYS` |
| availability_type | The availability type for the master instance. Can be either `REGIONAL` or `null` | string | Text |  `REGIONAL` |
| database_version | The database version to use | string | Title | MYSQL_5_7 |
| db_name | The name of the default database to create | string | Text | wordpress |
| deletion_protection | Used to block Terraform from deleting a SQL Instance. | bool| Title | false |
| disk_size | The disk size for the master instance |number | Text | 10 |
| disk_type | The disk type for the master instance. | string | Title | PD_SSD |
|name | The name of the Cloud SQL resources| string | Text | projectx |
| project_id | The project ID to manage the Cloud SQL resources | string | Title | oizududusloekcuq |
| region | The region of the Cloud SQL resources | string | Text | us-central1 |
| tier | The tier for the master instance. | string | Title | db-n1-standard-1 |
| user_host | The host for the default user | string | Text | admin.com |
| user_name | The name of the default user |string | Title | admin |
| user_password | The password for the default user. If not set, a random one will be generated and available in the generated_user_password output variable | string | Text | changeme |
| zone | The zone for the master instance, it should be something like: `us-central1-a`, `us-east1-c`. | string | Title | us-central1-c |


## Outputs
| Output      | Title | Description |
| ----------- | ----------- | ----------- |
| google_sql_database_instance.projectx.connection_name      | instance_connection_name       | The connection name of the master instance to be used in connection strings   | 
| google_sql_database_instance.projectx.first_ip_address     | instance_first_ip_address     | The first IPv4 address of the addresses assigned for the master instance| 
| google_sql_database_instance.projectx.ip_address      | instance_ip_address    | The IPv4 address assigned for the master instance   | 
|google_sql_database_instance.projectx.name      |instance_name       | The instance name for the master instance |
| google_sql_database_instance.projectx.private_ip_address     | private_address      | The private IP address assigned for the master instance  | 
|google_sql_database_instance.projectx.self_link     |instance_self_link      |The URI of the master instance   | 


## Examples
[![button](http://gstatic.com/cloudssh/images/open-btn.png)](https://console.cloud.google.com/cloudshell/open?git_repo=https://github.com/anaghirghilijiu/terraform_SQL_GCP.git)


## Acknowledgements
Give credit here.
- This project was inspired by...
- This project was based on [this tutorial](https://www.example.com).
- Many thanks to...

