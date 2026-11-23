output "vpc_id" {
  description = "ID of the project VPC."
  value       = aws_vpc.project.id
}

output "public_subnet_id" {
  description = "ID of the public subnet."
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "ID of the private subnet."
  value       = aws_subnet.private.id
}

output "web_public_ip" {
  description = "Public IPv4 address of the Nginx web server."
  value       = aws_instance.web.public_ip
}

output "bastion_public_ip" {
  description = "Public IPv4 address of the bastion host."
  value       = aws_instance.bastion.public_ip
}

output "database_private_ip" {
  description = "Private IPv4 address of the database server."
  value       = aws_instance.database.private_ip
}
