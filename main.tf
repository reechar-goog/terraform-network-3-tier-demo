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
