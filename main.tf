terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.6.0"
    }
    random = { source = "hashicorp/random" }
  }
}

provider "aws" {
  region = "eu-west-1"
}

data "aws_vpc" "this" {
  default = true
}

data "aws_security_group" "this" {
  name   = "default"
  vpc_id = data.aws_vpc.this.id
}

data "aws_subnet_ids" "this" {
  vpc_id = data.aws_vpc.this.id
}


resource "random_pet" "this" {}

module "my_workerpool" {
  source = "github.com/spacelift-io/terraform-aws-spacelift-workerpool-on-ec2?ref=e954914020a5e1a561038cba27bb9d06438deba6"

  configuration = <<-EOT
    export SPACELIFT_LAUNCHER_BINARIES_DOWNLOAD_URL=https://downloads.spacelift.dev
    export SPACELIFT_TOKEN="${var.spacelift_token}"
    export SPACELIFT_POOL_PRIVATE_KEY="${var.spacelift_pool_private_key}"
  EOT

  domain_name       = "spacelift.dev"
  min_size          = var.worker_pool_size
  max_size          = var.worker_pool_size
  ami_id            = var.ami_id
  worker_pool_id    = random_pet.this.id
  security_groups = [data.aws_security_group.this.id]
  vpc_subnets     = data.aws_subnet_ids.this.ids
}
