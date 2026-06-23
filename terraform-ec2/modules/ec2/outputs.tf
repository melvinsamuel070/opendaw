output "instance_id" {
  value = aws_instance.this[0].id
}

output "public_ip" {
  value = aws_instance.this[0].public_ip
}
