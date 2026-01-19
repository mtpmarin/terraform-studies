variable "origin_domain" {
  description = "The domain name of the origin server"
  type        = string
}
variable "distribution_comment" {
  description = "A comment to describe the CloudFront distribution"
  type        = string
  default     = "My CloudFront Distribution"
} 

variable "default_root_object" {
  description = "The default root object for the CloudFront distribution"
  type        = string
  default     = "index.html"
}

variable "origin_id" {
  description = "The unique identifier for the origin"
  type        = string
}