variable "amis" {
  type = map(string)
  description = "ID of images on AWS by region"
  default = {
    us-east-1 = "ami-08c40ec9ead489470"
    us-east-2 = "ami-0a9790c5a531163ee"
  }
}

variable "cidrs_remote_access" {
  type = list(string)
  default = [ "0.0.0.0/32", "0.0.0.0/32" ]
}

variable "key_name" {
  type = string
  default = "terraform-aws"
}