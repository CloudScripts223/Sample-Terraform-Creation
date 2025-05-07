# dev/main.tf
provider "aws" {
  region = "us-east-1"
}

module "dev_vpc" {
  source             = "../modules/vpc"
  vpc_name           = "dev-vpc"
  vpc_cidr           = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  availability_zone   = "us-east-1a"
}

output "dev_vpc_id" {
  value = module.dev_vpc.vpc_id
}

output "dev_public_subnet_id" {
  value = module.dev_vpc.public_subnet_id
}

output "dev_private_subnet_id" {
  value = module.dev_vpc.private_subnet_id
}

output "dev_security_group_id" {
  value = module.dev_vpc.security_group_id
}
