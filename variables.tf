variable "billing_id" {
  description = "Billing Account ID to charge"
}

variable "org_id" {
  description = "Organization for demo"
}

variable "xpn_host_project_id" {
  description = "Project ID to use for XPN Host project"
}

variable "xpn_service_project_id_1" {
  description = "Project ID to use for Service Project 1: Guestbook"
}

variable "xpn_service_project_id_2" {
  description = "Project ID to use for Service Project 2: Todo"
}

variable "todo_eng_email" {
  description = "email for all Todo developers"
  default     = "todo-eng@reechar.co"
}

variable "todo_web_email" {
  description = "email for all Todo web developers"
  default     = "todo-web-dev@reechar.co"
}

variable "todo_app_email" {
  description = "email for all Todo app developers"
  default     = "todo-app-dev@reechar.co"
}

variable "todo_db_email" {
  description = "email for all Todo DB developers"
  default     = "todo-db-dev@reechar.co"
}

variable "guestbook_eng_email" {
  description = "email for all Guestbook developers"
  default     = "guestbook-eng@reechar.co"
}

variable "guestbook_web_email" {
  description = "email for all Guestbook DB developers"
  default     = "guestbook-web-dev@reechar.co"
}

variable "guestbook_app_email" {
  description = "email for all Guestbook app developers"
  default     = "guestbook-app-dev@reechar.co"
}

variable "guestbook_db_email" {
  description = "email for all Guestbook DB developers"
  default     = "guestbook-db-dev@reechar.co"
}
