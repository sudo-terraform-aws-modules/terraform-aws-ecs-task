variable "name" {
  type        = string
  description = "(optional) Specify the task definition name. Default: random name prefix with sudo"
  default     = null
}

variable "cpu" {
  type        = number
  description = "(optional) Specify the number of CPU for the task"
  default     = 256
}
variable "memory" {
  type        = number
  description = "The amount (in MiB) of memory to present to the container. If your container attempts to exceed the memory specified here, the container is killed. Default: 512"
  default     = 512
}

variable "container_definitions" {
  type        = string
  description = "(optional) describe your variable"
  default     = ""
}

variable "execution_role_arn" {
  type        = string
  description = "(optional) Specify the exeuction role ARN"
  default     = null
}

variable "task_role_arn" {
  type        = string
  description = "(optional) Specify the task role ARN"
  default     = null
}
