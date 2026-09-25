locals {
  task_definition_name  = var.name == null ? "sudo-td-${random_string.random_name[0].result}" : var.name
  container_definitions = var.container_definitions != null ? var.container_definitions : jsonencode([{}])
}

resource "random_string" "random_name" {
  count   = var.name == null ? 1 : 0
  length  = 8
  special = false
  upper   = false
}
