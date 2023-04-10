variable "inst_type"{
    type=string
    default="t2.micro"
}

variable "key_name"{
    description="Instanse Key Name"
    type=string
    default="3tier"
}

variable "monit_inst"{
    description="Monitoring of Instance"
    type=bool
    default=true
}

variable "bast_vpc_sg_pub"{
    description="VPC SG for public"
    type=any
    default=["aws_security_group.bastion_host_sg.id"]
}

variable "pub_sub_1"{
    description="Public Subnet for EC2"
    type=string
    default="aws_subnet.public_sub_1.id"
}

variable "pub_sub_2"{
    description="Public Subnet for EC2"
    type=string
    default="aws_subnet.public_sub_2.id"
}

variable "public_ip"{
    type=bool
    default=true
}