# allocate elastic ip, this will be use for the nat-gateway in public subnet az1a
resource "aws_eip" "eip1" {
  domain   = "vpc"

  tags = {
      Name = "${var.project_name}-${var.environment}-eip1"
    }

}

# allocate elastic ip, this will be use for the nat-gateway in public subnet az1b
resource "aws_eip" "eip2" {
  domain   = "vpc"

  tags = {
      Name = "${var.project_name}-${var.environment}-eip2"
    }

}

# create nat gateway in public subnet az1a
resource "aws_nat_gateway" "nat_gateway_az1a" {
    allocation_id = aws_eip.eip1.id
    subnet_id = var.public_subnet_az1a_id

    tags = {
      Name = "${var.project_name}-${var.environment}-nat_gateway_az1a"
    }

    lifecycle {
    prevent_destroy = false
  }

    depends_on = [var.internet_gateway_id]

}

# create nat gateway in public subnet az1b
resource "aws_nat_gateway" "nat_gateway_az1b" {
    allocation_id = aws_eip.eip2.id 
    subnet_id = var.public_subnet_az1b_id

    tags = {
      Name = "${var.project_name}-${var.environment}-nat_gateway_az1b"
    }

    lifecycle {
    prevent_destroy = false
  }

    depends_on = [ var.internet_gateway_id]

}

# create private app route table and add  route though nat gateway az1a
resource "aws_route_table" "private_app_route_table_az1a" {
    vpc_id = var.vpc_id

    route {
        cidr_block = var.default_cidr
        nat_gateway_id = aws_nat_gateway.nat_gateway_az1a.id 
    }

    

    tags = {
      Name = "${var.project_name}-${var.environment}-private_app_route_table_az1a"
    }
  
}

# create private app route table and add route though nat gateway az1a
resource "aws_route_table" "private_app_route_table_az1b" {
    vpc_id = var.vpc_id

    route {
        cidr_block = var.default_cidr
        nat_gateway_id = aws_nat_gateway.nat_gateway_az1b.id  
    }

    tags = {
      Name = "${var.project_name}-${var.environment}-private_app_route_table_az1b"
    }
  
}


# create private data route table and add  route though nat gateway az1a
resource "aws_route_table" "private_route_data_table_az1a" {
    vpc_id = var.vpc_id

    route {
        cidr_block = var.default_cidr
        nat_gateway_id = aws_nat_gateway.nat_gateway_az1a.id  
    }

    tags = {
      Name = "${var.project_name}-${var.environment}-private_data_route_table_az1a"
    }
  
}

# create private data route table and add  route though nat gateway az1b
resource "aws_route_table" "private_route_data_table_az1b" {
    vpc_id = var.vpc_id

    route {
        cidr_block = var.default_cidr
        nat_gateway_id = aws_nat_gateway.nat_gateway_az1b.id  
    }

    tags = {
      Name = "${var.project_name}-${var.environment}-private_data_route_table_az1b"
    }
  
}

# association of private app route table to private app subnet az1a
resource "aws_route_table_association" "association_private_app_rt_az1a" {
    route_table_id = aws_route_table.private_app_route_table_az1a.id 
    subnet_id = var.private_app_subnet_az1a_id
  
}

# association of private app route table to private app subnet az1b
resource "aws_route_table_association" "association_private_app_rt_az1b" {
    route_table_id = aws_route_table.private_app_route_table_az1b.id 
    subnet_id = var.private_app_subnet_az1b_id
  
}

# association of private data route table to private data subnet az1a
resource "aws_route_table_association" "association_private_data_rt_az1a" {
    route_table_id = aws_route_table.private_route_data_table_az1a.id  
    subnet_id = var.private_data_subnet_az1a_id
  
}

# association of private data route table to private data subnet az1b
resource "aws_route_table_association" "association_private_data_rt_az1b" {
    route_table_id = aws_route_table.private_route_data_table_az1b.id   
    subnet_id = var.private_data_subnet_az1b_id
  
}