resource "google_compute_instance" "guestbook_web" {
  project      = "${google_project.demo_guestbook_project.project_id}"
  name         = "guestbook-web"
  machine_type = "n1-standard-1"
  zone         = "us-east1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.web_tier_subnet.self_link}"

    access_config {
      // Ephemeral IP
    }
  }

  service_account {
    scopes = ["cloud-platform"]
    email  = "${google_service_account.guestbook-web-sa.email}"
  }

  depends_on = ["google_compute_shared_vpc_service_project.service_guestbook"]
}

resource "google_compute_instance" "guestbook_app" {
  project      = "${google_project.demo_guestbook_project.project_id}"
  name         = "guestbook-app"
  machine_type = "n1-standard-1"
  zone         = "us-east1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.app_tier_subnet.self_link}"

    access_config {
      // Ephemeral IP
    }
  }

  service_account {
    scopes = ["cloud-platform"]
    email  = "${google_service_account.guestbook-app-sa.email}"
  }

  depends_on = ["google_compute_shared_vpc_service_project.service_guestbook"]
}

resource "google_compute_instance" "guestbook_db" {
  project      = "${google_project.demo_guestbook_project.project_id}"
  name         = "guestbook-db"
  machine_type = "n1-standard-1"
  zone         = "us-east1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.db_tier_subnet.self_link}"

    access_config {
      // Ephemeral IP
    }
  }

  service_account {
    scopes = ["cloud-platform"]
    email  = "${google_service_account.guestbook-db-sa.email}"
  }

  depends_on = ["google_compute_shared_vpc_service_project.service_guestbook"]
}
