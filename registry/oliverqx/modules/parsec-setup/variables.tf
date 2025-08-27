variable "agent_id" {
  type        = string
  description = "The ID of the Coder agent where Parsec will be installed."
}

variable "parsec_team_key" {
  type        = string
  description = "The Parsec for Teams Computer Key for headless authentication."
  sensitive   = true
}