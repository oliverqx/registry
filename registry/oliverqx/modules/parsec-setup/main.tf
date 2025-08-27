terraform {
  required_providers {
    coder  = { source = "coder/coder" }
  }
}

resource "coder_script" "install_parsec" {
  agent_id          = var.agent_id
  display_name      = "Install Parsec"
  icon              = "/icon/parsec.svg"
  run_on_start      = true

  script = <<-EOT
    #!/bin/bash
    set -e

    # Check if the environment variable for the key is set.
    if [ -z "$PARSEC_TEAM_KEY" ]; then
      echo "Error: PARSEC_TEAM_KEY environment variable not set. Cannot configure Parsec."
      exit 1
    fi

    echo "--- Installing Parsec dependencies ---"
    sudo apt-get update
    sudo apt-get install -y wget

    echo "--- Downloading Parsec headless client ---"
    wget "https://builds.parsec.app/parsec-linux-headless.deb" -O /tmp/parsec.deb

    echo "--- Installing Parsec ---"
    sudo dpkg -i /tmp/parsec.deb

    echo "--- Configuring Parsec for Teams ---"
    # The user must be 'coder' as that's the default user in the workspace.
    sudo psh team_computer --key "$PARSEC_TEAM_KEY" --user coder

    echo "--- Starting Parsec service ---"
    sudo systemctl start parsec

    echo "--- Parsec setup complete. Connect with your Parsec client. ---"
  EOT
}