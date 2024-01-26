terraform {
  backend "s3" {
    bucket = "hoang-remote"
    key = "mystate-1/terraform.tfstate"
    region = "ap-southeast-1"
  }
}

data "terraform_remote_state" "remote1" {
  backend = "s3"
  config = {
    bucket = "hoang-remote"
    key = "mystate/terraform.tfstate"
    region = "ap-southeast-1"
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_ebs_volume" "ebs_volume" {
  availability_zone = "ap-southeast-1a"
  size = 10
}

resource "aws_volume_attachment" "name" {
  volume_id = aws_ebs_volume.ebs_volume.id
  instance_id = data.terraform_remote_state.remote1.outputs.instance_id
  device_name = "/dev/sdh"
}