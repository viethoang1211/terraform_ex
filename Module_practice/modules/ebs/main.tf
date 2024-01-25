# Provide 2 10GB EBS storage devices
resource "aws_ebs_volume" "name1" {
    availability_zone = var.ebs_azs
    size = 10
}

resource "aws_ebs_volume" "name2" {
    size = 10
    availability_zone = var.ebs_azs
}