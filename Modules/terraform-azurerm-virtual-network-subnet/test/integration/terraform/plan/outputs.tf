output "subnet_id" {
  value = { for k, v in module.subnet : k => v.subnet_id }
}

output "subnet_name" {
  value = { for k, v in module.subnet : k => v.subnet_name }
}
