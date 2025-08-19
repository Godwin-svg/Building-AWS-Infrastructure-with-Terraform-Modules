# export the region
output "region" {
    value = var.region 
}

# export the project name
output "project_name" {
    value = var.project_name
}

# export the environment
output "environment" {
    value = var.environment
}

# export the vpc id
output "vpc_id" {
    value = aws_vpc.vpc.id   
}

# export internet gateway 
output "internet_gateway" {
    value = aws_internet_gateway.internet-gateway 
}


# export the public subnet az1a id
output "public_subnet_az1a_id" {
    value = aws_subnet.public_subnet_az1a.id 
}

#  export the public subnet az1b id
output "public_subnet_az1b_id" {
    value = aws_subnet.public_subnet_az1b.id 
}

# export the private app subnet az1a id
output "private_app_subnet_az1a_id" {
    value = aws_subnet.private_app_subnet_az1a.id  
}

# export the private app subnet az1b id
output "private_app_subnet_az1b_id" {
    value = aws_subnet.private_app_subnet_az1b.id   
}

# export the private data subnet az1a id
output "private_data_subnet_az1a_id" {
    value = aws_subnet.private_data_subnet_az1a.id  
}

# export the private data subnet az1b id
output "private_data_subnet_az1b_id" {
    value = aws_subnet.private_data_subnet_az1b.id   
}