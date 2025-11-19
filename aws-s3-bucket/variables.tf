variable "aws_region" {
  description = "The AWS region where the S3 bucket will be created."
  type        = string
  default     = "ca-central-1"
}

variable "org_name" {
  description = "Short name of the organization used to build resource names"
  type        = string
}

variable "cloudsibyl_account_id" {
  description = "CloudSibyl AWS account ID"
  type        = string
}

variable "cloudsibyl_external_id" {
  description = "External ID that CloudSibyl sends you in the onboarding email"
  type        = string
}

variable "enable_cloudsibyl_access" {
  description = "Whether to create CloudSibyl IAM role after bucket is set up"
  type        = bool
  default     = false
}
