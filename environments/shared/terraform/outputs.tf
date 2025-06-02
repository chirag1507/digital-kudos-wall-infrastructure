output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}

output "instance_public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.app_server.public_dns
}

output "frontend_url" {
  description = "URL to access the frontend application"
  value       = "http://${aws_instance.app_server.public_ip}:${var.frontend_port}"
}

output "backend_url" {
  description = "URL to access the backend API"
  value       = "http://${aws_instance.app_server.public_ip}:${var.backend_port}"
}

output "ssh_command" {
  description = "SSH command to connect to the instance"
  value       = var.key_name != "" ? "ssh -i ~/.ssh/${var.key_name}.pem ec2-user@${aws_instance.app_server.public_ip}" : "SSH key not configured"
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app_server.id
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public.id
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.app_server.id
}

output "environment" {
  description = "Environment name"
  value       = var.environment
} 