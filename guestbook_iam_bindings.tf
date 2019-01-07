resource "google_project_iam_member" "guestbook_project_view" {
  project = "${google_project.demo_guestbook_project.project_id}"
  role    = "roles/viewer"
  member  = "group:${var.guestbook_eng_email}"
}

resource "google_project_iam_member" "guestbook_project_compute" {
  project = "${google_project.demo_guestbook_project.project_id}"
  role    = "roles/compute.instanceAdmin.v1"
  member  = "group:${var.guestbook_eng_email}"
}

resource "google_compute_subnetwork_iam_binding" "guestbook-web-subnet" {
  subnetwork = "${google_compute_subnetwork.web_tier_subnet.name}"
  role       = "roles/compute.networkUser"
  project    = "${google_project.xpn_host_project.project_id}"
  region     = "us-east1"

  members = [
    "group:${var.guestbook_web_email}",
  ]
}

resource "google_service_account_iam_binding" "guestbook-web-sa" {
  service_account_id = "projects/${google_project.demo_guestbook_project.project_id}/serviceAccounts/${google_service_account.guestbook-web-sa.email}"
  role               = "roles/iam.serviceAccountUser"

  members = [
    "group:${var.guestbook_web_email}",
  ]
}

resource "google_compute_subnetwork_iam_binding" "guestbook-app-subnet" {
  subnetwork = "${google_compute_subnetwork.app_tier_subnet.name}"
  role       = "roles/compute.networkUser"
  project    = "${google_project.xpn_host_project.project_id}"
  region     = "us-east1"

  members = [
    "group:${var.guestbook_app_email}",
  ]
}

resource "google_service_account_iam_binding" "guestbook-app-sa" {
  service_account_id = "projects/${google_project.demo_guestbook_project.project_id}/serviceAccounts/${google_service_account.guestbook-app-sa.email}"
  role               = "roles/iam.serviceAccountUser"

  members = [
    "group:${var.guestbook_app_email}",
  ]
}

resource "google_compute_subnetwork_iam_binding" "guestbook-db-subnet" {
  subnetwork = "${google_compute_subnetwork.db_tier_subnet.name}"
  role       = "roles/compute.networkUser"
  project    = "${google_project.xpn_host_project.project_id}"
  region     = "us-east1"

  members = [
    "group:${var.guestbook_db_email}",
  ]
}

resource "google_service_account_iam_binding" "guestbook-db-sa" {
  service_account_id = "projects/${google_project.demo_guestbook_project.project_id}/serviceAccounts/${google_service_account.guestbook-db-sa.email}"
  role               = "roles/iam.serviceAccountUser"

  members = [
    "group:${var.guestbook_db_email}",
  ]
}
