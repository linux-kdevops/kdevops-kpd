# All generic output goes here

# Each provider's output.tf needs to define a public_ip_map. This
# map is used to build the Ansible controller's ssh configuration.
# Each map entry contains the node's hostname and public IP address.
output "public_ip_map" {
  description = "The public IP addresses assigned to each instance"
  value       = zipmap(var.kdevops_nodes[*], aws_eip.kdevops_eip[*].public_ip)
}

output "block_device_map" {
  description = "The block devices assigned to each instance"
  value       = zipmap(var.kdevops_nodes[*],
                       module.kdevops_ebs_volumes[*].ebs_volume_map)
}
