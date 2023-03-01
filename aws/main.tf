terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 2.0"
    }  
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias = "us-east-2"
  region = "us-east-2"
}


resource "aws_instance" "dev" {
  //count = 1
  ami = var.amis["us-east-1"]
  instance_type = "t2.micro"
  key_name = var.key_name
  /*tags = {
    Name = "dev${count.index}"
  }
  */
  tags = {
    Name = "dev"
  }
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
}

resource "aws_instance" "hml" {
  provider = aws.us-east-2
  //count = 1
  ami = var.amis["us-east-2"]
  instance_type = "t2.micro"
  key_name = var.key_name
  /*tags = {
    Name = "dev${count.index}"

  }
  */
  tags = {
    Name = "hml"
  }
  vpc_security_group_ids = ["${aws_security_group.allow_ssh_us_east_2.id}"]
}

resource "aws_s3_bucket" "dev" {
  bucket = "ivancl4udio-dev"
  acl = "private"

  tags = {
    Name = "ivancl4udio-dev"
  }
  depends_on = [
    aws_instance.dev
  ]
}

resource "aws_dynamodb_table" "dynamodb-homologacao" {
  provider = aws.us-east-2
  name = "GameScores"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "UserId"
  range_key = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }

}