#vpc
resource "aws_vpc" "test-vpc-01" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    tags = {
        Name = "test-vpc-01"
        team = var.tag_team
        config_platform = var.tag_platform
    }
}
#public subnet
resource "aws_subnet" "test-public" {
    vpc_id = aws_vpc.test-vpc-01.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tags = {
        Name = "test-public"
        team = var.tag_team
        config_platform = var.tag_platform
    }
}
#private subnet
resource "aws_subnet" "test-private" {
    vpc_id = aws_vpc.test-vpc-01.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1a"
    tags = {        
        Name = "test-private"
        team = var.tag_team
        config_platform = var.tag_platform
    }       
}
#internet gateway
resource "aws_internet_gateway" "test-igw" {
    vpc_id = aws_vpc.test-vpc-01.id
    tags = {
        Name = "test-igw"
        team = var.tag_team
        config_platform = var.tag_platform
    }
}
#route table
resource "aws_route_table" "test-rt" {
    vpc_id = aws_vpc.test-vpc-01.id

    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.test-igw.id
    }
    
    tags = {
        Name = "test-rt"
        team= var.tag_team
        platform = var.tag_platform
    }
  
}
#route table association
resource "aws_route_table_association" "test-public-subnet-association" {
    subnet_id = aws_subnet.test-public.id
    route_table_id = aws_route_table.test-rt.id
}
#security group
resource "aws_security_group" "test-sg" {
    name = "test-sg"
    description = "Allow SSH and HTTP inbound traffic"
    vpc_id = aws_vpc.test-vpc-01.id
    tags = {
        Name = "test-sg"
        team = var.tag_team
        config_platform = var.tag_platform
    }
}
resource "aws_vpc_security_group_ingress_rule" "inbound_ssh" {
    security_group_id = aws_security_group.test-sg.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 22
    ip_protocol = "tcp"
    to_port = 22
}
resource "aws_vpc_security_group_ingress_rule" "inbound_http" {
    security_group_id = aws_security_group.test-sg.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 80
    ip_protocol = "tcp"
    to_port = 80
}   

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.test-sg.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
}