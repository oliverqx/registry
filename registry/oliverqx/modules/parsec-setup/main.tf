resource "coder_script" "install_parsec_macos" {
  agent_id     = coder_agent.main.id
  display_name = "Setup Parsec Host"
  icon         = "/icon/parsec.svg"
  run_on_start = true

  script = <<-EOT
    #!/bin/bash
    set -e

    # Check if the PARSEC_TEAM_KEY environment variable is set.
    if [ -z "$PARSEC_TEAM_KEY" ]; then
      echo "Error: PARSEC_TEAM_KEY environment variable not set. Cannot configure Parsec."
      exit 1
    fi

    # --- 1. Check for Homebrew ---
    echo "--- Checking for Homebrew ---"
    if ! command -v brew &> /dev/null; then
      echo "Homebrew not found. Please install it from https://brew.sh/"
      exit 1
    fi
    echo "--- Homebrew found. ---"

    # --- 2. Install Parsec ---
    echo "--- Installing Parsec via Homebrew ---"
    # This will install the Parsec application to /Applications/Parsec.app
    brew install --cask parsec

    # --- 3. Configure Parsec ---
    echo "--- Configuring Parsec for Teams ---"
    # The path to the Parsec daemon executable on macOS
    PARSEC_DAEMON="/Applications/Parsec.app/Contents/MacOS/parsecd"
    
    # Configure the host with your team key.
    # Note: This may prompt for administrator privileges on your Mac.
    sudo "$PARSEC_DAEMON" team_key="$PARSEC_TEAM_KEY"

    # --- 4. Start Parsec ---
    echo "--- Starting Parsec service ---"
    # Start the Parsec host service.
    sudo "$PARSEC_DAEMON"

    echo "--- Parsec setup complete. Your Mac should now be available as a host. ---"
  EOT
}