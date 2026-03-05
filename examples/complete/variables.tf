variable "region" {
  description = "The region where to deploy the resources"
  type        = string
  default     = "cn-hangzhou"
}

variable "common_tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default = {
    Environment = "test"
    Project     = "terraform-alicloud-alidns"
    ManagedBy   = "Terraform"
  }
}

variable "domain_group_name" {
  description = "The name of the domain group"
  type        = string
  default     = "tf-example-group"
}

variable "domain_name" {
  description = "The domain name to manage"
  type        = string
  default     = "example-terraform.com"
}

variable "create_dns_instance" {
  description = "Whether to create a DNS instance"
  type        = bool
  default     = true # This can be created independently
}

variable "create_gtm_instance" {
  description = "Whether to create a GTM instance"
  type        = bool
  default     = true # Enable GTM instance creation for testing
}

variable "gtm_instance_name" {
  description = "The name of the GTM instance"
  type        = string
  default     = "terraform-gtm-example"
}

