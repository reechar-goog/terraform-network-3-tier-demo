resource "google_compute_instance" "todo_web" {
  project      = "${google_project.demo_todo_project.project_id}"
  name         = "todo-web"
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
    email  = "${google_service_account.todo-web-sa.email}"
  }
}

resource "google_compute_instance" "todo_app" {
  project      = "${google_project.demo_todo_project.project_id}"
  name         = "todo-app"
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
    email  = "${google_service_account.todo-app-sa.email}"
  }
}

resource "google_compute_instance" "todo_db" {
  project      = "${google_project.demo_todo_project.project_id}"
  name         = "todo-db"
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
    email  = "${google_service_account.todo-db-sa.email}"
  }
}
