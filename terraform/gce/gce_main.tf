provider "google" {
  project = var.GOOGLE_CLOUD_PROJECT_ID
}

resource "tls_private_key" "orchestrator_ssh_key_ed25519" {
  algorithm = "ED25519"
}
locals {
  SSH_PUBLIC_KEY = trimspace(tls_private_key.orchestrator_ssh_key_ed25519.public_key_openssh)
  SSH_PRIVATE_KEY = tls_private_key.orchestrator_ssh_key_ed25519.private_key_openssh
}

output "INSTANCES_PRIVATE_SSH_KEY" {
  value = local.SSH_PRIVATE_KEY
}

output "GPU_INSTANCES_PUBLIC_IP_ADDRESSES" {
  value = ["${google_compute_instance.gpu_vms[*].network_interface.0.access_config.0.nat_ip}"]
}