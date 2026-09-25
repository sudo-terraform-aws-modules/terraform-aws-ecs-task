variable "name" {
  type        = string
  description = "(optional) Task definition family name. Default: randomly generated"
  default     = null
}

variable "cpu" {
  type        = number
  description = "(optional) Number of CPU units for the task. Default: 256"
  default     = 256
}

variable "memory" {
  type        = number
  description = "(optional) Amount of memory (in MiB) for the task. Default: 512"
  default     = 512
}

variable "container_definitions" {
  type        = string
  description = "Container definitions as a JSON array string. Use the ecs-container module's container_definition_json_list output."
  default     = null
}

variable "requires_compatibilities" {
  type        = list(string)
  description = "(optional) Launch types the task is compatible with. Default: [\"FARGATE\"]"
  default     = ["FARGATE"]
}

variable "network_mode" {
  type        = string
  description = "(optional) Docker networking mode. Default: awsvpc"
  default     = "awsvpc"
  validation {
    condition     = contains(["awsvpc", "bridge", "host", "none"], var.network_mode)
    error_message = "network_mode must be one of: awsvpc, bridge, host, none."
  }
}

variable "execution_role_arn" {
  type        = string
  description = "(optional) IAM role ARN for the ECS container agent to pull images and publish logs"
  default     = null
}

variable "task_role_arn" {
  type        = string
  description = "(optional) IAM role ARN that the task's containers can assume"
  default     = null
}

variable "volumes" {
  type = list(object({
    name      = string
    host_path = optional(string)
    efs_volume_configuration = optional(object({
      file_system_id          = string
      root_directory          = optional(string, "/")
      transit_encryption      = optional(string, "ENABLED")
      authorization_config = optional(object({
        access_point_id = optional(string)
        iam             = optional(string, "ENABLED")
      }))
    }))
  }))
  description = "(optional) Volumes to attach to the task definition. Default: []"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "(optional) Tags to apply to the task definition"
  default     = {}
}
