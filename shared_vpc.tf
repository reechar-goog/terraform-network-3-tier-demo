resource "google_compute_shared_vpc_host_project" "host" {
  project = "${google_project.xpn_host_project.project_id}"
}

resource "google_compute_shared_vpc_service_project" "service_guestbook" {
  host_project    = "${google_project.xpn_host_project.project_id}"
  service_project = "${google_project.demo_guestbook_project.project_id}"
  depends_on      = ["google_compute_shared_vpc_host_project.host"]
}

resource "google_compute_shared_vpc_service_project" "service_todo" {
  host_project    = "${google_project.xpn_host_project.project_id}"
  service_project = "${google_project.demo_todo_project.project_id}"
  depends_on      = ["google_compute_shared_vpc_host_project.host"]
}

resource "google_compute_subnetwork" "web_tier_subnet" {
  name          = "web-tier-subnet"
  ip_cidr_range = "10.10.10.0/24"
  project       = "${google_project.xpn_host_project.project_id}"
  network       = "${google_compute_network.shared_vpc.self_link}"
  region        = "us-east1"
}

resource "google_compute_subnetwork" "app_tier_subnet" {
  name          = "app-tier-subnet"
  ip_cidr_range = "10.10.20.0/24"
  project       = "${google_project.xpn_host_project.project_id}"
  network       = "${google_compute_network.shared_vpc.self_link}"
  region        = "us-east1"
}

resource "google_compute_subnetwork" "db_tier_subnet" {
  name          = "db-tier-subnet"
  ip_cidr_range = "10.10.30.0/24"
  project       = "${google_project.xpn_host_project.project_id}"
  network       = "${google_compute_network.shared_vpc.self_link}"
  region        = "us-east1"
}

resource "google_compute_network" "shared_vpc" {
  project                 = "${google_project.xpn_host_project.project_id}"
  name                    = "shared-vpc-host"
  auto_create_subnetworks = false
}

# module "shared-vpc" {
#   source          = "github.com/terraform-google-modules/terraform-google-network"
#   project_id      = "${google_project.xpn_host_project.project_id}"
#   network_name    = "shared-vpc-host"
#   shared_vpc_host = true


#   subnets = [
#     {
#       subnet_name   = "web-tier-subnet"
#       subnet_ip     = "10.10.10.0/24"
#       subnet_region = "c"
#     },
#     {
#       subnet_name   = "app-tier-subnet"
#       subnet_ip     = "10.10.20.0/24"
#       subnet_region = "us-east1"
#     },
#     {
#       subnet_name   = "db-tier-subnet"
#       subnet_ip     = "10.10.30.0/24"
#       subnet_region = "us-east1"
#     },
#   ]


#   secondary_ranges = {
#     web-tier-subnet = [
#       {
#         range_name    = "web-tier-secondary-subnet"
#         ip_cidr_range = "192.168.64.0/24"
#       },
#     ]


#     app-tier-subnet = []
#     db-tier-subnet  = []
#   }
# }

