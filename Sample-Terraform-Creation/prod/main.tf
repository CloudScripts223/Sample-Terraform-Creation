# prod/main.tf
provider "aws" {
  region = "us-east-1"
}

module "prod_vpc" {
  source             = "../modules/vpc"
  vpc_name           = "prod-vpc"
  vpc_cidr           = "10.3.0.0/16"
  public_subnet_cidr = "10.3.1.0/24"
  private_subnet_cidr = "10.3.2.0/24"
  availability_zone   = "us-east-1d"
}

output "prod_vpc_id" {
  value = module.prod_vpc.vpc_id
}

output "prod_public_subnet_id" {
  value = module.prod_vpc.public_subnet_id
}

output "prod_private_subnet_id" {
  value = module.prod_vpc.private_subnet_id
}

output "prod_security_group_id" {
  value = module.prod_vpc.security_group_id
}
