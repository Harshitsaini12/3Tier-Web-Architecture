output "pri_ec2_ami"{
    value=aws_instance.private_ec2.ami
}

output "pub_ec2_ami"{
    value=aws_instance.public_ec2.ami
}

output "pri_ec2_id"{
    value=aws_instance.private_ec2.id
}

output "pub_ec2_id"{
    value=aws_instance.public_ec2.id
}