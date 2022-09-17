resource "aws_ecs_task_definition" "task" {
  family                   = local.task_definition_name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory
  container_definitions    = jsonencode([jsondecode(local.container_definitions)])

  execution_role_arn = var.execution_role_arn
  task_role_arn      = var.task_role_arn
  lifecycle {
    create_before_destroy = true
  }
}

module "container" {
  source  = "sudo-terraform-aws-modules/ecs-container/aws"
  version = "1.0.2"
}
