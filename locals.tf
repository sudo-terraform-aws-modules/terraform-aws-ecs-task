locals {
  task_definition_name  = var.name == null ? "sudo-td-${random_string.random_name[0].result}" : var.name
  container_definitions = var.container_definitions == null ? module.container.container_definition_json : var.container_definitions
}

resource "random_string" "random_name" {
  count   = var.name == null ? 1 : 0
  length  = 8
  special = false
  upper   = false
}
