variable "policy_name" {
  type        = string
  default     = "S3-Bucket-Access-Policy"
  description = "Policy Name"
}

variable "policy_des"{
    type=string
    default="Provides permission to access S3"
}

variable "role_name"{
    type=string
    description="Role Name"
    default="threetierrole"
}

variable "policy_att"{
    type=string
    default="policy_attachment"
}

variable "inst_prof"{
    type=string
    description="Profile Name"
    default="private_profile"
}

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

variable "vpc_sg_pri"{
    description="VPC SG for private"
    type=any
    default=["aws_security_group.Private_EC2.id"]
}

variable "vpc_sg_pub"{
    description="VPC SG for public"
    type=any
    default=["aws_security_group.Public_EC2.id"]
}

variable "pri_sub"{
    description="Private Subnet for EC2"
    type=string
    default="aws_subnet.private_sub_1.id"
}

variable "pub_sub"{
    description="Public Subnet for EC2"
    type=string
    default="aws_subnet.public_sub_1.id"
}

variable "public_ip"{
    type=bool
    default=true
}