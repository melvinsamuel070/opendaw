locals {
  ami_map = {
    x86 = "ami-091138d0f0d41ff90"
    arm = "ami-07ad186bc37b8dac4"
  }

  ami_id = local.ami_map[var.architecture]
}