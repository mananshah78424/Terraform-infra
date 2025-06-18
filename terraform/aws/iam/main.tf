module "nomad_prod_user" {
  source = "../../modules/iam"

  user_name    = "nomad-prod-user"
  user_path    = "/prod/"
  environment  = "production"
  purpose      = "nomad-server"
  
  # You can override the default policy actions if needed
  # policy_actions = [
  #   "ec2:RunInstances",
  #   "ec2:StopInstances",
  #   # ... add or remove actions as needed
  # ]
}

# Output the credentials instructions
output "credentials_instructions" {
  value = module.nomad_prod_user.credentials_instructions
  sensitive = true
}

# Output the user ARN (useful for references)
output "user_arn" {
  value = module.nomad_prod_user.user_arn
}