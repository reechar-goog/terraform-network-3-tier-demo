module "todo_project_iam_bindings" {
  source = "github.com/terraform-google-modules/terraform-google-iam"

  projects = ["${google_project.demo_todo_project.project_id}"]

  bindings = {
    "roles/viewer" = [
      "group:todo-eng@reechar.co",
    ]

    "roles/compute.instanceAdmin.v1" = [
      "group:todo-eng@reechar.co",
    ]
  }
}

module "todo_web_subnet_iam_binding" {
  source = "github.com/terraform-google-modules/terraform-google-iam"

  subnets = ["projects/reechar-3t-demo-xpn/regions/us-east1/subnetworks/web-tier-subnet"]

  bindings = {
    "roles/compute.networkUser" = [
      "group:todo-web-dev@reechar.co",
    ]
  }
}

module "todo_web_sa_iam_binding" {
  source = "github.com/terraform-google-modules/terraform-google-iam"

  project          = "${google_project.demo_todo_project.project_id}"
  service_accounts = ["${google_service_account.todo-web-sa.email}"]

  bindings = {
    "roles/iam.serviceAccountUser" = [
      "group:todo-web-dev@reechar.co",
    ]
  }
}

module "todo_app_subnet_iam_binding" {
  source = "github.com/terraform-google-modules/terraform-google-iam"

  subnets = ["projects/reechar-3t-demo-xpn/regions/us-east1/subnetworks/app-tier-subnet"]

  bindings = {
    "roles/compute.networkUser" = [
      "group:todo-app-dev@reechar.co",
    ]
  }
}

module "todo_app_sa_iam_binding" {
  source = "github.com/terraform-google-modules/terraform-google-iam"

  project          = "${google_project.demo_todo_project.project_id}"
  service_accounts = ["${google_service_account.todo-app-sa.email}"]

  bindings = {
    "roles/iam.serviceAccountUser" = [
      "group:todo-app-dev@reechar.co",
    ]
  }
}

module "todo_db_subnet_iam_binding" {
  source = "github.com/terraform-google-modules/terraform-google-iam"

  subnets = ["projects/reechar-3t-demo-xpn/regions/us-east1/subnetworks/db-tier-subnet"]

  bindings = {
    "roles/compute.networkUser" = [
      "group:todo-db-dev@reechar.co",
    ]
  }
}

module "todo_db_sa_iam_binding" {
  source = "github.com/terraform-google-modules/terraform-google-iam"

  project          = "${google_project.demo_todo_project.project_id}"
  service_accounts = ["${google_service_account.todo-db-sa.email}"]

  bindings = {
    "roles/iam.serviceAccountUser" = [
      "group:todo-db-dev@reechar.co",
    ]
  }
}
