provider "google-beta" {}

resource "google_folder" "demo_folder" {
  display_name = "Three Tier XPN Demo Folder"
  parent       = "organizations/794966888850"
}

resource "google_project" "xpn_host_project" {
  name                = "Shared VPC Host 3T Demo"
  project_id          = "reechar-3t-demo-xpn"
  folder_id           = "${google_folder.demo_folder.name}"
  billing_account     = "0030A3-D6BEAE-9C7088"
  auto_create_network = false
}

resource "google_project" "demo_guestbook_project" {
  name                = "Demo App1- guestbook"
  project_id          = "reechar-3t-demo-guestbook"
  folder_id           = "${google_folder.demo_folder.name}"
  billing_account     = "0030A3-D6BEAE-9C7088"
  auto_create_network = false
}

resource "google_project" "demo_todo_project" {
  name                = "Demo App2- todo"
  project_id          = "reechar-3t-demo-todo"
  folder_id           = "${google_folder.demo_folder.name}"
  billing_account     = "0030A3-D6BEAE-9C7088"
  auto_create_network = false
}

resource "google_compute_shared_vpc_host_project" "host" {
  project = "${google_project.xpn_host_project.project_id}"
}

resource "google_compute_shared_vpc_service_project" "service_guestbook" {
  host_project    = "${google_project.xpn_host_project.project_id}"
  service_project = "${google_project.demo_guestbook_project.project_id}"
}

resource "google_compute_shared_vpc_service_project" "service_todo" {
  host_project    = "${google_project.xpn_host_project.project_id}"
  service_project = "${google_project.demo_todo_project.project_id}"
}

module "shared-vpc" {
  source          = "github.com/terraform-google-modules/terraform-google-network"
  project_id      = "${google_project.xpn_host_project.project_id}"
  network_name    = "shared-vpc-host"
  shared_vpc_host = true

  subnets = [
    {
      subnet_name   = "web-tier-subnet"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = "us-east1"
    },
    {
      subnet_name   = "app-tier-subnet"
      subnet_ip     = "10.10.20.0/24"
      subnet_region = "us-east1"
    },
    {
      subnet_name   = "db-tier-subnet"
      subnet_ip     = "10.10.30.0/24"
      subnet_region = "us-east1"
    },
  ]

  secondary_ranges = {
    web-tier-subnet = [
      {
        range_name    = "web-tier-secondary-subnet"
        ip_cidr_range = "192.168.64.0/24"
      },
    ]

    app-tier-subnet = []
    db-tier-subnet  = []
  }
}

resource "google_service_account" "guestbook-web-sa" {
  account_id   = "guestbook-web"
  display_name = "Guestbook Web Tier SA "
  project      = "${google_project.demo_guestbook_project.project_id}"
}

resource "google_service_account" "guestbook-app-sa" {
  account_id   = "guestbook-app"
  display_name = "Guestbook App Tier SA "
  project      = "${google_project.demo_guestbook_project.project_id}"
}

resource "google_service_account" "guestbook-db-sa" {
  account_id   = "guestbook-db"
  display_name = "Guestbook DB Tier SA "
  project      = "${google_project.demo_guestbook_project.project_id}"
}

resource "google_service_account" "todo-web-sa" {
  account_id   = "todo-web"
  display_name = "Todo Web Tier SA "
  project      = "${google_project.demo_todo_project.project_id}"
}

resource "google_service_account" "todo-app-sa" {
  account_id   = "todo-app"
  display_name = "Todo App Tier SA "
  project      = "${google_project.demo_todo_project.project_id}"
}

resource "google_service_account" "todo-db-sa" {
  account_id   = "todo-db"
  display_name = "Todo DB Tier SA "
  project      = "${google_project.demo_todo_project.project_id}"
}

module "guestbook_project_iam_bindings" {
  source = "github.com/terraform-google-modules/terraform-google-iam"

  projects = ["${google_project.demo_guestbook_project.project_id}"]

  bindings = {
    "roles/viewer" = [
      "group:guestbook-eng@reechar.co",
    ]

    "roles/compute.admin" = [
      "group:guestbook-eng@reechar.co",
    ]
  }
}

module "guestbook_web_subnet_iam_binding" {
  source = "github.com/terraform-google-modules/terraform-google-iam"

  subnets = ["projects/reechar-3t-demo-xpn/regions/us-east1/subnetworks/web-tier-subnet"]

  bindings = {
    "roles/compute.networkUser" = [
      "group:guestbook-web-dev@reechar.co",
    ]
  }
}

module "guestbook_web_sa_iam_binding" {
  source = "github.com/terraform-google-modules/terraform-google-iam"

  project          = "${google_project.demo_guestbook_project.project_id}"
  service_accounts = ["${google_service_account.guestbook-web-sa.email}"]

  bindings = {
    "roles/iam.serviceAccountUser" = [
      "group:guestbook-web-dev@reechar.co",
    ]
  }
}
