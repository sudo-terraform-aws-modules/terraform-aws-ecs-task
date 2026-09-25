# SUDO AWS Terraform Module for ECS Task Definition

Creates an AWS ECS Task Definition with support for Fargate and EC2 launch types, EFS volumes, IAM roles, and configurable networking.

## Usage

### Basic Fargate Task

```hcl
module "container" {
  source = "sudo-terraform-aws-modules/ecs-container/aws"

  name   = "app"
  image  = "nginx:latest"
  cpu    = 256
  memory = 512
}

module "task" {
  source  = "sudo-terraform-aws-modules/ecs-task/aws"
  version = "1.0.0"

  name                  = "my-task"
  cpu                   = 256
  memory                = 512
  container_definitions = module.container.container_definition_json
}
```

### Task with IAM Roles and Logging

```hcl
module "task" {
  source  = "sudo-terraform-aws-modules/ecs-task/aws"
  version = "1.0.0"

  name                  = "my-task"
  cpu                   = 512
  memory                = 1024
  container_definitions = module.container.container_definition_json
  execution_role_arn    = module.execution_role.arn
  task_role_arn         = module.task_role.arn

  tags = { Environment = "prod" }
}
```

### EC2 Launch Type with EFS Volume

```hcl
module "task" {
  source  = "sudo-terraform-aws-modules/ecs-task/aws"
  version = "1.0.0"

  name                     = "my-task"
  requires_compatibilities = ["EC2"]
  network_mode             = "bridge"
  cpu                      = 512
  memory                   = 1024
  container_definitions    = module.container.container_definition_json

  volumes = [
    {
      name = "data"
      efs_volume_configuration = {
        file_system_id = "fs-12345678"
        root_directory = "/data"
      }
    }
  ]
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.0, < 7.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.0, < 7.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.1 |

## Resources

| Name | Type |
|------|------|
| [aws_ecs_task_definition.task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [random_string.random_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Task definition family name. Default: randomly generated | `string` | `null` | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | Number of CPU units for the task | `number` | `256` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Amount of memory (in MiB) for the task | `number` | `512` | no |
| <a name="input_container_definitions"></a> [container\_definitions](#input\_container\_definitions) | Container definitions JSON string | `string` | `null` | no |
| <a name="input_requires_compatibilities"></a> [requires\_compatibilities](#input\_requires\_compatibilities) | Launch types the task is compatible with | `list(string)` | `["FARGATE"]` | no |
| <a name="input_network_mode"></a> [network\_mode](#input\_network\_mode) | Docker networking mode (awsvpc, bridge, host, none) | `string` | `"awsvpc"` | no |
| <a name="input_execution_role_arn"></a> [execution\_role\_arn](#input\_execution\_role\_arn) | IAM role ARN for the ECS container agent | `string` | `null` | no |
| <a name="input_task_role_arn"></a> [task\_role\_arn](#input\_task\_role\_arn) | IAM role ARN that the task containers can assume | `string` | `null` | no |
| <a name="input_volumes"></a> [volumes](#input\_volumes) | Volumes to attach to the task definition | `list(object({...}))` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the task definition | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_task_definition_arn"></a> [task\_definition\_arn](#output\_task\_definition\_arn) | Full ARN of the task definition (includes revision) |
| <a name="output_task_definition_arn_without_revision"></a> [task\_definition\_arn\_without\_revision](#output\_task\_definition\_arn\_without\_revision) | ARN of the task definition without the revision suffix |
| <a name="output_family"></a> [family](#output\_family) | Task definition family name |
| <a name="output_revision"></a> [revision](#output\_revision) | Task definition revision number |
<!-- END_TF_DOCS -->
