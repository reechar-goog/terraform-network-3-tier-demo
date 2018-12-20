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
