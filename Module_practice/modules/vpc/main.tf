# VPC
resource "aws_vpc" "hoang_vpc" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = var.aws_vpc_name
    }
}

# subnets : public
resource "aws_subnet" "hoang_public" {
    count = length(var.subnets_cidr)

    # take the ID , formula : resource_type.resource_name.id
    vpc_id = aws_vpc.hoang_vpc.id
    
    cidr_block = element(var.subnets_cidr, count.index)
    availability_zone = element(var.azs, count.index)
    tags = {
        Name = "Demo-Subnet-${count.index+1}"
    }
}

# Internet gateway
resource "aws_internet_gateway" "hoang_igw" {
    vpc_id = aws_vpc.hoang_vpc.id
    tags = {
        Name = var.aws_igw_name 
    }
}

# Route table : attach Internet Gateway
resource "aws_route_table" "hoang_rt" {
    vpc_id = aws_vpc.hoang_vpc.id

    # cho phep thanh phan trong vpc truy cap internet
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.hoang_igw.id
    }
    tags = {
        Name = var.aws_rt_name
    }
}

# Route table association with public subnets
resource "aws_route_table_association" "name" {
    count = length(var.subnets_cidr)
    subnet_id = element(aws_subnet.hoang_public.*.id,count.index)
    route_table_id = aws_route_table.hoang_rt.id
}
