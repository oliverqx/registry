variable "gcp_zone" {
  type        = string
  description = "The GCP zone to create the workspace in."
  default     = "us-central1-a"
}

variable "PARSEC_TEAM_KEY" {
  type        = string
  description = "The secret key for Parsec for Teams."
  sensitive   = true
}
