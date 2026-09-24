resource "random_uuid" "resource" {}

resource "aws_kms_alias" "resource" {
  name          = "alias/${coalesce(var.name, random_uuid.resource.id)}"
  target_key_id = var.target_key_id
}

output "id" {
  description = "The full name of the alias, including the 'alias/' prefix."
  value       = aws_kms_alias.resource.id
}

output "name" {
  description = "The full name of the alias, including the 'alias/' prefix this module adds."
  value       = aws_kms_alias.resource.name
}

output "arn" {
  description = "The ARN of the alias."
  value       = aws_kms_alias.resource.arn
}
