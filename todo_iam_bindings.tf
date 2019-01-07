resource "google_project_iam_member" "todo_project_view" {
  project = "${google_project.demo_todo_project.project_id}"
  role    = "roles/viewer"
  member  = "group:${var.todo_eng_email}"
}

resource "google_project_iam_member" "todo_project_compute" {
  project = "${google_project.demo_todo_project.project_id}"
  role    = "roles/compute.instanceAdmin.v1"
  member  = "group:${var.todo_eng_email}"
}

resource "google_compute_subnetwork_iam_binding" "todo-web-subnet" {
  subnetwork = "${google_compute_subnetwork.web_tier_subnet.name}"
  role       = "roles/compute.networkUser"
  project    = "${google_project.xpn_host_project.project_id}"
  region     = "us-east1"

  members = [
    "group:${var.todo_web_email}",
  ]
}

resource "google_service_account_iam_binding" "todo-web-sa" {
  service_account_id = "projects/${google_project.demo_todo_project.project_id}/serviceAccounts/${google_service_account.todo-web-sa.email}"
  role               = "roles/iam.serviceAccountUser"

  members = [
    "group:${var.todo_web_email}",
  ]
}

resource "google_compute_subnetwork_iam_binding" "todo-app-subnet" {
  subnetwork = "${google_compute_subnetwork.app_tier_subnet.name}"
  role       = "roles/compute.networkUser"
  project    = "${google_project.xpn_host_project.project_id}"
  region     = "us-east1"

  members = [
    "group:${var.todo_app_email}",
  ]
}

resource "google_service_account_iam_binding" "todo-app-sa" {
  service_account_id = "projects/${google_project.demo_todo_project.project_id}/serviceAccounts/${google_service_account.todo-app-sa.email}"
  role               = "roles/iam.serviceAccountUser"

  members = [
    "group:${var.todo_app_email}",
  ]
}

resource "google_compute_subnetwork_iam_binding" "todo-db-subnet" {
  subnetwork = "${google_compute_subnetwork.db_tier_subnet.name}"
  role       = "roles/compute.networkUser"
  project    = "${google_project.xpn_host_project.project_id}"
  region     = "us-east1"

  members = [
    "group:${var.todo_db_email}",
  ]
}

resource "google_service_account_iam_binding" "todo-db-sa" {
  service_account_id = "projects/${google_project.demo_todo_project.project_id}/serviceAccounts/${google_service_account.todo-db-sa.email}"
  role               = "roles/iam.serviceAccountUser"

  members = [
    "group:${var.todo_db_email}",
  ]
}
