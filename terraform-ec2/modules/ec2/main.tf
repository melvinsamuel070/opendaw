resource "aws_security_group" "ec2_sg" {
  name_prefix = "ec2-sg-"

  # SSH access for GitHub Actions bootstrapping
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access required for Certbot Let's Encrypt automated challenge validation
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS access for secure, encrypted user traffic routing to Marzban
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.instance_name}-sg"
  }
}

resource "aws_instance" "this" {
  count = var.instance_count

  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  # 👇 ADD THIS LINE TO BAKE IN DOCKER ON BOOT
  user_data = file("${path.root}/userdata.sh")

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.instance_name}-${count.index + 1}"
  }
}