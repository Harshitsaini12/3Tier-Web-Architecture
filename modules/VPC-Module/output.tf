output "Private_EC2_id"{
    value=aws_security_group.Private_EC2.id
}

output "Public_EC2_id"{
    value=aws_security_group.Public_EC2.id
}

output "pri_sub_1_id"{
    value=aws_subnet.private_sub_1.id
}

output "pub_sub_1_id"{
    value=aws_subnet.public_sub_1.id
}

output "pub_sub_2_id"{
    value=aws_subnet.public_sub_2.id
}

output "pri_sub_id"{
    value=[aws_subnet.private_sub_1.id,aws_subnet.private_sub_2.id]
}

output "pub_sub_id"{
    value=[aws_subnet.public_sub_1.id,aws_subnet.public_sub_2.id]
}

output "internal_lb_sg_id"{
    value=aws_security_group.Internal_LB.id
}

output "intern_lb_sub_id"{
    value=[aws_subnet.private_sub_1.id,aws_subnet.private_sub_2.id]
}

output "extern_lb_sg_id"{
    value=aws_security_group.External_LB.id
}

output "extern_lb_sub_id"{
    value=[aws_subnet.public_sub_1.id,aws_subnet.public_sub_2.id]
}

output "awsvpc_id"{
    value=aws_vpc.threetiervpc.id
}

output "bast_sg"{
    value=aws_security_group.bastion_host_sg.id
}

output "DB_sub_id"{
    value = [aws_subnet.private_sub_DB_1.id, aws_subnet.private_sub_DB_2.id]
}

output "DB_sg_id"{
    value = aws_security_group.DBMS.id
}