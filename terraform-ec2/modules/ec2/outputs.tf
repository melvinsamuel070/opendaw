output "instance_id" {
  value = aws_instance.this[0].id
}

output "instance_public_ip" {
  value = aws_instance.this[0].instance_public_ip
}
