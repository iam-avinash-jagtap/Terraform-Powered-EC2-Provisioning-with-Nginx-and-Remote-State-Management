# This Output is for - Count

# Print Private IP, Public IP & DNS of the Instance
#output "public_IP" {
# value = aws_instance.Terra-Server[*].public_ip
#}
#
#output "DNS" {
# value = aws_instance.Terra-Server[*].public_dns
#}
# This output is - For each 
output "public_ip" {
  value = [
    for instance in aws_instance.Terra-Server : instance.public_ip
  ]
}

output "public_dns" {
  value = [
    for instance in aws_instance.Terra-Server : instance.public_dns
  ]
}

output "private_ip" {
  value = [
    for instance in aws_instance.Terra-Server : instance.private_ip
  ]
}