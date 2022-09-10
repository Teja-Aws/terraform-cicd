output "apacheip" {
  value       = aws_instance.apache.public_ip
}

output "cicdip" {
  value = aws_instance.cicd.public_ip
}

output "apachedns" {
  value       = aws_instance.apache.public_dns
}

output "cicddns" {
  value = aws_instance.cicd.public_dns
}