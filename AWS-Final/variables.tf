variable "access_key" {}
variable "secret_key" {}

variable "key_pair_name" {
  description = "Enter you key pair name"
}

variable "bucket_name" {
  description = "bucket name"
  default     = "kdeyko-aws-bucket"
}

variable "region" {
  default = "us-east-2"
}

variable "amis" {
  type = "map"

  default = {
    "us-east-1" = "ami-759bc50a"
    "us-east-2" = "ami-5e8bb23b"
  }
}

variable "instance_type" {
  description = "AWS instance type"
  default     = "t2.micro"
}

variable "asg_min" {
  description = "Min numbers of servers in ASG"
  default     = "2"
}

variable "asg_max" {
  description = "Max numbers of servers in ASG"
  default     = "5"
}

variable "asg_desired" {
  description = "Desired numbers of servers in ASG"
  default     = "2"
}

variable "image_name" {
  default = "cat.jpg"
}
