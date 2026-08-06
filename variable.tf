variable "ami" {
  description = "The ami ID to use for the imstance"
  type        = string
  default     = "ami-0e80e7e160cbfbc53"
}

variable "instance_type" {
  description = "type of instance to use"
  type        = string
  default     = "t3.micro"
}

variable "vpc_id" {
  description = "ID of the VPC where the security group will be created"
  type        = string
  default     = "vpc-084a10f473fb0a8bb"
}

variable "key_name" {
  description = "key pair name use for SSH access"
  type        = string
  default     = "Ajay_devs"
}

variable "subnet_ids" {
  description = "subnet ID"
  type        = list(string)
  default     = ["subnet-094550475922cd8b7", "subnet-0a5ed46193c043c4c", "subnet-085fe175dbfb2e30f"]

}

variable "certificate_arn" {
  description = "aws acm certificate"
  type        = string
  default     = "arn:aws:acm:ca-central-1:043391333186:certificate/e5cc7edc-1d70-4037-9976-b7864448685d"
}