output "gcp_instance_name" {
  description = "The name of the Google Cloud VM."
  value       = module.vm_gcp_setup.instance_name
}

output "gcp_instance_ip" {
  description = "The public IP address of the Google Cloud VM."
  value       = module.vm_gcp_setup.instance_ip_address
}

output "coder_agent_id" {
  description = "The ID of the Coder agent."
  value       = coder_agent.main.id
}