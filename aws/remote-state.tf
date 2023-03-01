terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "ivancl4udio"
    workspaces {
      name = "aws-ivancl4udio"
    }
  }
}