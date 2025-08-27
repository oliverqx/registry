# Define the providers required for this template.
terraform {
  required_providers {
    google = { source = "hashicorp/google" }
    coder  = { source = "coder/coder" }
  }
}

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


# --- MODULES & RESOURCES ---

# 1. Call the Infrastructure module to create the VM.
module "vm_gcp_setup" {
  source        = "./modules/vm-gcp-setup"
  instance_name = "coder-d"
  zone          = var.gcp_zone
  gcp_project_id = "spherical-park-469623-v9"
}

# # 2. Define the Coder agent that will run on the VM.
resource "coder_agent" "main" {
  auth            = "google-instance-identity"
  os              = "linux"
  arch            = "amd64"

  env = {
    PARSEC_TEAM_KEY = var.PARSEC_TEAM_KEY
  }
}

# # 3. Call the Desktop Setup module.
module "desktop_env_xfce_setup" {
  source   = "./modules/desktop-env-xfce-setup"
  agent_id = coder_agent.main.id

  depends_on = [module.vm_gcp_setup]
}

# # 4. Call the Parsec Install module.
# This depends on the desktop module having run first. Coder runs scripts
# in the order they are defined, ensuring dependencies are met.
module "parsec_setup" {
  source          = "./modules/parsec-setup"
  agent_id        = coder_agent.main.id
  parsec_team_key = var.PARSEC_TEAM_KEY
  
  # Explicitly depend on the desktop setup to ensure correct order.
  depends_on = [module.desktop_env_xfce_setup]
}