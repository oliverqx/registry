variable "gcp_project_id" {
  type        = string
  description = "The GCP project ID to deploy resources in."
}

variable "zone" {
  type        = string
  description = "The GCP zone to deploy the VM in (e.g., 'us-central1-a')."
  default     = "us-central1-a"
}

variable "instance_name" {
  type        = string
  description = "A unique name for the virtual machine."
  default     = "gpu-workspace-vm"
}