terraform {
  required_providers {
    coder  = { source = "coder/coder" }
  }
}

resource "coder_script" "install_desktop" {
  agent_id          = var.agent_id
  display_name      = "Install Desktop Environment"
  icon              = "/icon/desktop.svg"
  run_on_start      = true

  script = <<-EOT
    #!/bin/bash
    set -e
    
    echo "--- Updating package list ---"
    sudo apt-get update
    
    echo "--- Installing XFCE Desktop ---"
    # Use DEBIAN_FRONTEND=noninteractive to prevent interactive prompts during installation.
    export DEBIAN_FRONTEND=noninteractive
    sudo apt-get install -y xfce4 xfce4-goodies dbus-x11
    
    echo "--- Desktop environment installed successfully ---"
  EOT
}