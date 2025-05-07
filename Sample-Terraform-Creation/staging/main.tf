# staging/main.tf
provider "aws" {
  region = "us-east-1"
}

module "staging_vpc" {
  source             = "../modules/vpc"
  vpc_name           = "staging-vpc"
  vpc_cidr           = "10.1.0.0/16"
  public_subnet_cidr = "10.1.1.0/24"
  private_subnet_cidr = "10.1.2.0/24"
  availability_zone   = "us-east-1b"
}

output "staging_vpc_id" {
  value = module.staging_vpc.vpc_id
}

output "staging_public_subnet_id" {
  value = module.staging_vpc.public_subnet_id
}

output "staging_private_subnet_id" {
  value = module.staging_vpc.private_subnet_id
}

output "staging_security_group_id" {
  value = module.staging_vpc.security_group_id
}
