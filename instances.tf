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
    subnetwork = "projects/reechar-3t-demo-xpn/regions/us-east1/subnetworks/web-tier-subnet"

    access_config {
      // Ephemeral IP
    }
  }

  service_account {
    scopes = ["cloud-platform"]
    email  = "${google_service_account.guestbook-web-sa.email}"
  }
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
    subnetwork = "projects/reechar-3t-demo-xpn/regions/us-east1/subnetworks/app-tier-subnet"

    access_config {
      // Ephemeral IP
    }
  }

  service_account {
    scopes = ["cloud-platform"]
    email  = "${google_service_account.guestbook-app-sa.email}"
  }
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
    subnetwork = "projects/reechar-3t-demo-xpn/regions/us-east1/subnetworks/db-tier-subnet"

    access_config {
      // Ephemeral IP
    }
  }

  service_account {
    scopes = ["cloud-platform"]
    email  = "${google_service_account.guestbook-db-sa.email}"
  }
}
