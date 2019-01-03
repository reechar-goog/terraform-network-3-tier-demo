module "guestbook_project_iam_bindings" {
  source = "github.com/terraform-google-modules/terraform-google-iam"

  projects = ["${google_project.demo_guestbook_project.project_id}"]

  bindings = {
    "roles/viewer" = [
      "group:guestbook-eng@reechar.co",
    ]

    "roles/compute.instanceAdmin.v1" = [
      "group:guestbook-eng@reechar.co",
    ]
  }
}

module "guestbook_web_subnet_iam_binding" {
  source = "github.com/terraform-google-modules/terraform-google-iam"

  subnets = ["projects/reechar-3t-demo-xpn/regions/us-east1/subnetworks/web-tier-subnet"]

  bindings = {
    "roles/compute.networkUser" = [
      "group:guestbook-web-dev@reechar.co",
    ]
  }
}

module "guestbook_web_sa_iam_binding" {
  source = "github.com/terraform-google-modules/terraform-google-iam"

  project          = "${google_project.demo_guestbook_project.project_id}"
  service_accounts = ["${google_service_account.guestbook-web-sa.email}"]

  bindings = {
    "roles/iam.serviceAccountUser" = [
      "group:guestbook-web-dev@reechar.co",
    ]
  }
}

module "guestbook_app_subnet_iam_binding" {
  source = "github.com/terraform-google-modules/terraform-google-iam"

  subnets = ["projects/reechar-3t-demo-xpn/regions/us-east1/subnetworks/app-tier-subnet"]

  bindings = {
    "roles/compute.networkUser" = [
      "group:guestbook-app-dev@reechar.co",
    ]
  }
}

module "guestbook_app_sa_iam_binding" {
  source = "github.com/terraform-google-modules/terraform-google-iam"

  project          = "${google_project.demo_guestbook_project.project_id}"
  service_accounts = ["${google_service_account.guestbook-app-sa.email}"]

  bindings = {
    "roles/iam.serviceAccountUser" = [
      "group:guestbook-app-dev@reechar.co",
    ]
  }
}

module "guestbook_db_subnet_iam_binding" {
  source = "github.com/terraform-google-modules/terraform-google-iam"

  subnets = ["projects/reechar-3t-demo-xpn/regions/us-east1/subnetworks/db-tier-subnet"]

  bindings = {
    "roles/compute.networkUser" = [
      "group:guestbook-db-dev@reechar.co",
    ]
  }
}

module "guestbook_db_sa_iam_binding" {
  source = "github.com/terraform-google-modules/terraform-google-iam"

  project          = "${google_project.demo_guestbook_project.project_id}"
  service_accounts = ["${google_service_account.guestbook-db-sa.email}"]

  bindings = {
    "roles/iam.serviceAccountUser" = [
      "group:guestbook-db-dev@reechar.co",
    ]
  }
}
