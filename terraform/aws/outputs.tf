output "instance_ip" {
  value = aws_spot_instance_request.nomad_server.public_ip
}

output "nomad_ui" {
  value = "http://${aws_spot_instance_request.nomad_server.public_ip}:4646/ui"
}