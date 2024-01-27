resource "aws_key_pair" "custom_pair" {
  key_name = "examplekey"
  public_key = file("./terraform.pub")
}

resource "aws_security_group" "allow_http_ssh" {
  name = var.secGroupName
  description = var.secGroupDescription
  vpc_id = module.vpc.vpc_id
  tags = {
    Name = "Terraform"
  }

  ingress {
    description = "HTTP from VPC"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH access"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # outbound traffic : allow all the ports    
  
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "vm1_instance" {
  source = "./module/aws_ec2instance"
  ami_id= "ami-0fa377108253bf620"
  #aws_subnet_id= 
  security_group_ids= [aws_security_group.allow_http_ssh.id]
  key_name = aws_key_pair.custom_pair.key_name
  user_data = <<-EOF
        #!/bin/bash
        sudo apt-get update
        sudo apt-get install nginx -y
        sudo chmod 777 /usr/share/doc/HTML/index.html
        sudo echo "This is demo server 1" > /usr/share/nginx/html/index.html
        sudo systemctl restart nginx
EOF

}

module "vm2_instance" {
  source = "./module/aws_ec2instance"
  ami_id= "ami-0fa377108253bf620"
  #aws_subnet_id= 
  security_group_ids= [aws_security_group.allow_http_ssh.id]
  key_name = aws_key_pair.custom_pair.key_name
  user_data = <<-EOF
        #!/bin/bash
        sudo apt-get update
        sudo apt-get install nginx -y
        sudo chmod 777 /usr/share/doc/HTML/index.html
        sudo echo "This is demo server 2" > /usr/share/nginx/html/index.html
        sudo systemctl restart nginx
EOF

}