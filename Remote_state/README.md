Run " aws configure " to log in with aws  

Run " terraform init " to initialize resources

Run " terraform plan " to review  

Run " terraform apply " to create/modify resources  

Run " terraform destroy " to destroy created resources  

Scenario : 

Let's say we have two teams A and B, one that creates EC2 instance and the other one that creates EBS volume and attaches it to the EC2 instance created by team one. 

Team A creates the EC2 instance and stores the state file in AWS S3 bucket

Team B accesses the state file created by team A and then creates the EBS volume which then attaches to the EC2 instance

The state file for the infra created by team B also resides in AWS S3 bucket