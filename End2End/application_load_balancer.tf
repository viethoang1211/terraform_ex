module "application_alb" {
  source = "./modules/aws_alb"
  environment = "demo"
  aws_lb_name = "application_alb"
  aws_lb_internal = false
  aws_lb_type = "application"
#   subnets = 
  security_group_ids = [aws_security_group.allow_http_ssh.id]
}

module "aws_application_target_group" {
    source = "./modules/aws_lb_target_group"

}