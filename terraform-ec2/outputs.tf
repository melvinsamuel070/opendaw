output "instance_id" {
  value = module.ec2.instance_id
}

# CHANGE: rename public_ip to instance_public_ip
output "instance_public_ip" {
  value = module.ec2.public_ip
}