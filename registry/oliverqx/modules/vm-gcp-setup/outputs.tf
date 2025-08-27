output "instance_ip_address" {
  description = "The public IP address of the newly created VM."
  value       = google_compute_instance.vm.network_interface[0].access_config[0].nat_ip
}

output "instance_name" {
  description = "The name of the created VM instance."
  value       = google_compute_instance.vm.name
}

output "zone" {
  description = "The zone where the instance was created."
  value       = google_compute_instance.vm.zone
}