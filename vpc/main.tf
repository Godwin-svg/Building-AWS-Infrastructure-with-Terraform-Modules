# create vpc module
resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"
    enable_dns_hostnames = true

    tags = {
      Name = "${var.project_name}-${var.environment}-vpc"
    }
  
}

# create internet gateway and attach it to vpc
resource "aws_internet_gateway" "internet-gateway" {
    vpc_id = aws_vpc.vpc.id 

    tags = {
      Name = "${var.project_name}-${var.environment}-internet-gateway"
    }
 
}

# use data source to get all avalability zone in a region
data "aws_availability_zones" "avalability_zone" {}

# create public subnet az1a
resource "aws_subnet" "public_subnet_az1a" {
    vpc_id = aws_vpc.vpc.id 
    cidr_block = var.public_subnet_az1a_cidr
    availability_zone = data.aws_availability_zones.avalability_zone.names[0]
    map_public_ip_on_launch = true

    tags = {
      Name = "${var.project_name}-${var.environment}-public_subnet_az1a"
    }

    lifecycle {
    prevent_destroy = true
  }

}

# create public subnet az1b
resource "aws_subnet" "public_subnet_az1b" {
    vpc_id = aws_vpc.vpc.id 
    cidr_block = var.public_subnet_az1b_cidr
    availability_zone = data.aws_availability_zones.avalability_zone.names[1]
    map_public_ip_on_launch = true

    tags = {
      Name = "${var.project_name}-${var.environment}-public_subnet_az1b"
    }

}

# create route table and add public route
resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.vpc.id 

    route {
        cidr_block = var.default_cidr
        gateway_id = aws_internet_gateway.internet-gateway.id 
    } 

    tags = {
      Name = "${var.project_name}-${var.environment}-public_route_table"
    }
  
}

# associate public subnet az1a to "public route table"
resource "aws_route_table_association" "public_subnet_az1a_rt_association" {
    route_table_id = aws_route_table.public_route_table.id 
    subnet_id = aws_subnet.public_subnet_az1a.id 
  
}

# associate public subnet az1b to "public route table"
resource "aws_route_table_association" "public_subnet_az1b_rt_association" {
    route_table_id = aws_route_table.public_route_table.id 
    subnet_id = aws_subnet.public_subnet_az1b.id  
  
}


# create private app subnet az1a
resource "aws_subnet" "private_app_subnet_az1a" {
    vpc_id = aws_vpc.vpc.id 
    cidr_block = var.private_app_subnet_az1a_cidr
    availability_zone = data.aws_availability_zones.avalability_zone.names[0]
    map_public_ip_on_launch = false

    tags = {
      Name = "${var.project_name}-${var.environment}-private_app_subnet_az1a"
    }

}

# create private app subnet az1b
resource "aws_subnet" "private_app_subnet_az1b" {
    vpc_id = aws_vpc.vpc.id 
    cidr_block = var.private_app_subnet_az1b_cidr
    availability_zone = data.aws_availability_zones.avalability_zone.names[1]
    map_public_ip_on_launch = false

    tags = {
      Name = "${var.project_name}-${var.environment}-private_app_subnet_az1b"
    }

}

# create private data subnet az1a
resource "aws_subnet" "private_data_subnet_az1a" {
    vpc_id = aws_vpc.vpc.id 
    cidr_block = var.private_data_subnet_az1a_cidr
    availability_zone = data.aws_availability_zones.avalability_zone.names[0]
    map_public_ip_on_launch = false

    tags = {
      Name = "${var.project_name}-${var.environment}-private_data_subnet_az1a"
    }

}

# create private data subnet az1a
resource "aws_subnet" "private_data_subnet_az1b" {
    vpc_id = aws_vpc.vpc.id 
    cidr_block = var.private_data_subnet_az1b_cidr
    availability_zone = data.aws_availability_zones.avalability_zone.names[1]
    map_public_ip_on_launch = false

    tags = {
      Name = "${var.project_name}-${var.environment}-private_data_subnet_az1b"
    }

}