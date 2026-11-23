output "vpc_id" {
  description = "ID of the existing UNLOX project VPC."
  value       = var.vpc_id
}

output "public_subnet_id" {
  description = "ID of the existing public subnet."
  value       = var.public_subnet_id
}

output "private_subnet_id" {
  description = "ID of the existing private subnet."
  value       = var.private_subnet_id
}

output "web_public_ip" {
  description = "Public IPv4 address of the existing UNLOX web server."
  value       = data.aws_instance.web.public_ip
}

output "bastion_public_ip" {
  description = "Public IPv4 address of the new bastion host."
  value       = aws_instance.bastion.public_ip
}

output "database_private_ip" {
  description = "Private IPv4 address of the new database server."
  value       = aws_instance.database.private_ip
}
