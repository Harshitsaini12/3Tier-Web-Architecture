#ASG


variable "inst_name_pri"{
    description="Instance Name in Private ASG"
    type=string
    default="Private Launch Config"
}

variable "inst_name_pub"{
    description="Instance Name in Public ASG"
    type=string
    default="Public Launch Config"
}


variable "inst_imageid_pri"{
    description="Image ID"
    type=string
    default="aws_instance.private_ec2.ami"
}

variable "inst_imageid_pub"{
    description="Image ID"
    type=string
    default="aws_instance.public_ec2.ami"
}


variable "inst_type"{
    description="Instance Type in ASG"
    type=string
    default="t2.micro"
}

variable "public_ip"{
    description="Allow Public IP Address"
    type=bool
    default=true
}

variable "asg_name_pri"{
    description="ASG Name"
    type=string
    default="Private EC2 Auto Scailing"
}

variable "asg_name_pub"{
    description="ASG Name"
    type=string
    default="Public EC2 Auto Scailing"
}

variable "min_size"{
    type=number
    default=1
}

variable "max_size"{
    type=number
    default=2
}

variable "zone_ide_pri"{
    description="VPC Zone Identifiers Private"
    type=list(string)
    default=["aws_subnet.private_sub_1.id","aws_subnet.private_sub_2.id"]
}

variable "zone_ide_pub"{
    description="VPC Zone Identifiers Public"
    type=list(string)
    default=["aws_subnet.public_sub_1.id","aws_subnet.public_sub_2.id"]
}

variable "health_check"{
    type=string
    default="ELB"
}

variable "health_grace_per"{
    type=number
    default=300
}

# variable "tar_grp_pri"{
#     type=any
#     default=["aws_lb_target_group.private_tg.arn"]
# }

# variable "tar_grp_pub"{
#     type=any
#     default=["aws_lb_target_group.public_tg.arn"]
# }


#Load Balancer


variable "internal_name" {
  type        = string
  default     = "internal"
  description = "Internal LB Name"
}

variable "inter"{
    type=bool
    default=true
}

variable "lb_type"{
    description="Load Balancer Type"
    type=string
    default="application"
}

variable "intern_lb_sg"{
    description="Load Balancer SG"
    type=any
    default=["aws_security_group.Internal_LB.id"]
}

variable "intern_lb_sub"{
    description="Load Balancer Subnet"
    type=list(string)
    default=["aws_subnet.private_sub_1.id","aws_subnet.private_sub_2.id"]
}

variable "intern_lb_tg_name"{
    type=string
    default="PrivateTargetGroup"
}

variable "intern_lb_port"{
    type=number
    default=80
}

variable "intern_prot"{
    description="Internal LB Protocol"
    type=string
    default="HTTP"
}

variable "vpc_id"{
    type=string
    default="aws_vpc.threetiervpc.id"
}

variable "intern_tg_id"{
    type=string
    default="aws_instance.private_ec2.id"
}

variable "external_name" {
  type        = string
  default     = "external"
  description = "External LB Name"
}

variable "exter"{
    type=bool
    default=false
}

variable "extern_lb_sg"{
    description="Load Balancer SG"
    type=any
    default=["aws_security_group.External_LB.id"]
}

variable "extern_lb_sub"{
    description="Load Balancer Subnet"
    type=list(string)
    default=["aws_subnet.public_sub_1.id", "aws_subnet.public_sub_2.id"]
}

variable "extern_lb_tg_name"{
    type=string
    default="PublicTargetGroup"
}

variable "extern_tg_id"{
    type=string
    default="aws_instance.public_ec2.id"
}