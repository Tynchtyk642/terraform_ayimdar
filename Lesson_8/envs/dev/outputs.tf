output "subnets" {
  value = module.vpc.publics[*]
}
