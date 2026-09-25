output "task_definition_arn" {
  value       = aws_ecs_task_definition.task.arn
  description = "Full ARN of the task definition (includes revision)"
}

output "task_definition_arn_without_revision" {
  value       = aws_ecs_task_definition.task.arn_without_revision
  description = "ARN of the task definition without the revision suffix"
}

output "family" {
  value       = aws_ecs_task_definition.task.family
  description = "Task definition family name"
}

output "revision" {
  value       = aws_ecs_task_definition.task.revision
  description = "Task definition revision number"
}
