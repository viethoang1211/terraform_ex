terraform {
    backend "s3" {
        # The bucket you have created
        bucket = "hoang-remote"
        # Path to save the state file
        key = "mystate/terraform.tfstate"
        
        region = "ap-southeast-1"
    }
}

provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_instance" "instance1" {
  ami = "ami-0fa377108253bf620"
  instance_type = "t2.micro"
  availability_zone = "ap-southeast-1a"
}

output "instance_id" {
  value = aws_instance.instance1.id
}
output "public_ip" {
  value = aws_instance.instance1.public_ip
}