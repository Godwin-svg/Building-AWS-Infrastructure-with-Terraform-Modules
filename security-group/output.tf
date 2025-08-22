# export the alb security group id
output "alb_security_group_id" {
    value = aws_security_group.alb_security_group.id  
}


# export the bastion security group
output "bastion_security_group_id" {
    value = aws_security_group.bastion_security_group.id
}


# export the app server security group
output "app_server_security_group_id" {
    value = aws_security_group.app_server_security_group.id
}

# export datbase security group
output "database_security_group_id" {
    value = aws_security_group.database_security_group.id   
}