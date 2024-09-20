variable "spacelift_token" {
  type        = string
  description = "Spacelift token"
}

variable "spacelift_pool_private_key" {
  type        = string
  description = "Spacelift pool private key"
}

variable "worker_pool_size" {
    default = 2
    type = number
    description = "Number of workers in the pool"
}

variable "ami_id" {
    type = string
    description = "AMI ID to use for the worker pool"
}
