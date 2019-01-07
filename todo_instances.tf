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
    subnetwork = "${google_compute_subnetwork.web_tier_subnet.self_link}"

    access_config {
      // Ephemeral IP
    }
  }

  service_account {
    scopes = ["cloud-platform"]
    email  = "${google_service_account.todo-web-sa.email}"
  }

  depends_on = ["google_compute_shared_vpc_service_project.service_todo"]
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
    subnetwork = "${google_compute_subnetwork.app_tier_subnet.self_link}"

    access_config {
      // Ephemeral IP
    }
  }

  service_account {
    scopes = ["cloud-platform"]
    email  = "${google_service_account.todo-app-sa.email}"
  }

  depends_on = ["google_compute_shared_vpc_service_project.service_todo"]
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
    subnetwork = "${google_compute_subnetwork.db_tier_subnet.self_link}"

    access_config {
      // Ephemeral IP
    }
  }

  service_account {
    scopes = ["cloud-platform"]
    email  = "${google_service_account.todo-db-sa.email}"
  }

  depends_on = ["google_compute_shared_vpc_service_project.service_todo"]
}
