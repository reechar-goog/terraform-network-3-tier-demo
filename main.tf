provider "google-beta" {}

resource "google_folder" "demo_folder" {
  display_name = "Three Tier XPN Demo Folder"
  parent       = "organizations/${var.org_id}"
}

resource "google_project" "xpn_host_project" {
  name                = "Shared VPC Host 3T Demo"
  project_id          = "${var.xpn_host_project_id}"
  folder_id           = "${google_folder.demo_folder.name}"
  billing_account     = "${var.billing_id}"
  auto_create_network = false
}

resource "google_project" "demo_guestbook_project" {
  name                = "Demo App1- guestbook"
  project_id          = "${var.xpn_service_project_id_1}"
  folder_id           = "${google_folder.demo_folder.name}"
  billing_account     = "${var.billing_id}"
  auto_create_network = false
}

resource "google_project" "demo_todo_project" {
  name                = "Demo App2- todo"
  project_id          = "${var.xpn_service_project_id_2}"
  folder_id           = "${google_folder.demo_folder.name}"
  billing_account     = "${var.billing_id}"
  auto_create_network = false
}
