resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  project = "${google_project.xpn_host_project.project_id}"
  network = "${module.shared-vpc.network_name}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "guestbook_web_to_app" {
  name    = "guestbook-allow-web-to-app"
  project = "${google_project.xpn_host_project.project_id}"
  network = "${module.shared-vpc.network_name}"

  allow {
    protocol = "icmp"
  }

  source_service_accounts = ["${google_service_account.guestbook-web-sa.email}"]
  target_service_accounts = ["${google_service_account.guestbook-app-sa.email}"]
}

resource "google_compute_firewall" "guestbook_app_to_db" {
  name    = "guestbook-allow-app-to-db"
  project = "${google_project.xpn_host_project.project_id}"
  network = "${module.shared-vpc.network_name}"

  allow {
    protocol = "icmp"
  }

  source_service_accounts = ["${google_service_account.guestbook-app-sa.email}"]
  target_service_accounts = ["${google_service_account.guestbook-db-sa.email}"]
}
