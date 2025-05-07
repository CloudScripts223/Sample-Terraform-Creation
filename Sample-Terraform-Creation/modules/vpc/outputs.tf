output "vpc_id" {
  value = aws_vpc.vpc_main.id
}

output "public_subnet_id" {
  value = aws_subnet.subnet_public.id
}

output "private_subnet_id" {
  value = aws_subnet.subnet_private.id
}

output "security_group_id" {
  value = aws_security_group.sg_main.id
}
