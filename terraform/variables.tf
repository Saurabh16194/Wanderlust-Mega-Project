variable "aws_region" {
  description = "AWS region where resources will be provisioned"
  default     = "us-east-2"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-0e6a50b0059fd2cc3"
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  default     = "t2.large"
}

variable "sg_ports" {
    description = "list of ingress ports"
    type = list(object({
    from = number
    to   = number
  }))
  default = [
    { from = 30000, to = 32767 },
    { from = 80,    to = 80 },
    { from = 6379,  to = 6379 },
    { from = 443,   to = 443 },
    { from = 465,   to = 465 },
    { from = 3000,  to = 10000 },
    { from = 22,    to = 22 },
    { from = 25,    to = 25 },
    { from = 6443,  to = 6443 },
  ]
}