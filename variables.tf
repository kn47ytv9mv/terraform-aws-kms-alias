variable "name" {
  default     = null
  description = "The alias's own name, without the 'alias/' prefix AWS requires on every KMS alias — this module adds it automatically (e.g. 'my-app-key' becomes 'alias/my-app-key'). If null, a unique name is generated."

  validation {
    condition     = var.name == null || !startswith(var.name, "alias/")
    error_message = "name should not include the 'alias/' prefix — this module adds it automatically. Pass 'my-app-key', not 'alias/my-app-key'."
  }
}

variable "target_key_id" {
  default     = null
  description = "The ID or ARN of the KMS key this alias points to — from terraform-aws-kms-key's id or arn output."
}
