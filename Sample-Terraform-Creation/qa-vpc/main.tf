# qa/main.tf
provider "aws" {
  region = "us-east-1"
}

module "qa_vpc" {
  source             = "../modules/vpc"
  vpc_name           = "qa-vpc"
  vpc_cidr           = "10.2.0.0/16"
  public_subnet_cidr = "10.2.1.0/24"
  private_subnet_cidr = "10.2.2.0/24"
  availability_zone   = "us-east-1c"
}

output "qa_vpc_id" {
  value = module.qa_vpc.vpc_id
}

output "qa_public_subnet_id" {
  value = module.qa_vpc.public_subnet_id
}

output "qa_private_subnet_id" {
  value = module.qa_vpc.private_subnet_id
}

output "qa_security_group_id" {
  value = module.qa_vpc.security_group_id
}
