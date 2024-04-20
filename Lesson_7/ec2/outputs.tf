output "remote_state" {
  value = data.terraform_remote_state.networking
}

output "backend_netwokring" {
  value = data.terraform_remote_state.networking.config.key
}


output "remote_state_ec2" {
  value = data.terraform_remote_state.ec2
}
