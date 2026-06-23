module "ec2" {
  source = "./modules/ec2"

  instance_name  = var.instance_name
  instance_type  = var.instance_type
  key_name       = var.key_name
  instance_count = var.instance_count

  ami_id = local.ami_id
}
