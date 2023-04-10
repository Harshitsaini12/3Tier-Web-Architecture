variable "vpc_cidr" {
  description = "cidr for vpc"
  type        = string
  default     = "10.0.0.0/16"
}

variable "az_1" {
  description = "AZ for public subnet 1"
  type        = string
  default     = "us-east-1a"
}

variable "az_2" {
  description = "AZ for public subnet 2"
  type        = string
  default     = "us-east-1b"
}

variable "pub_sub_cidr_1" {
  description = "cidr for public subnet 1"
  type        = string
  default     = "10.0.0.0/24"
}

variable "pri_sub_cidr_1" {
  description = "cidr for private subnet 1"
  type        = string
  default     = "10.0.1.0/24"
}

variable "pub_sub_cidr_2" {
  description = "cidr for public subnet 2"
  type        = string
  default     = "10.0.3.0/24"
}

variable "pri_sub_cidr_2" {
  description = "cidr for private database subnet 1"
  type        = string
  default     = "10.0.2.0/24"
}

variable "pri_sub_cidr_3" {
  description = "cidr for private subnet 2"
  type        = string
  default     = "10.0.4.0/24"
}

variable "pri_sub_cidr_4" {
  description = "cidr for private database subnet 2"
  type        = string
  default     = "10.0.5.0/24"
}

variable "route_table_cidr"{
    description = "Route Table CIDR Range"
    type        = any
    default     = "0.0.0.0/0"
}

variable "extern_sg_name" {
  type        = string
  default     = "External_LB"
}


variable "extern_sg_des" {
  type        = string
  default     = "Allow External_LB Traffic"
}


variable "ing_from_to_port" {
  type        = number
  default     = 80
}


variable "egr_from_to_port" {
  type        = number
  default     = 0
}


variable "ingress_sg_protocol" {
  description = "protocol for security group"
  type        = string
  default     = "tcp"
}


variable "egress_sg_protocol" {
  type        = string
  default     = "1"
}


variable "extern_cidr_sg" {
  description = "cidr block for external"
  type        = any
  default     = "0.0.0.0/0"
}

variable "self_ip"{
    type       = bool
    default    = true
}

variable "ipv6_cidr" {
  description = "cidr block engress for ipv6"
  type        = string
  default     = "::/0"
}

variable "intern_sg_name" {
  type        = string
  default     = "Internal_LB"
}

variable "internal_description" {
  type        = string
  default     = "Allow Internal_LB Traffic"
}

variable "internal_description_ingress" {
  type        = string
  default     = "Internall_LB Traffic Inbound"
}

variable "internal_cidr_blk" {
  description = "cidr block engress for internal"
  type        = string 
  default     = "[aws_vpc.threetiervpc.cidr_block]"
}

variable "intern_ingress_sg" {
  type        = string
  default     = "[aws_security_group.Public_EC2.id]"
}


variable "public_sg_name" {
  type        = string
  default     = "Public_EC2"
}


variable "public_sg_desc" {
  type        = string
  default     = "Allow Public_EC2 Traffic"
}

variable "public_sg_desc_ingr" {
  type        = string
  default     = "Public_EC2 Traffic Inbound"
}

variable "pub_ingr_sg" {
  type        = string
  default     = "[aws_security_group.External_LB.id]"
}


variable "private_sg_name" {
  type        = string
  default     = "Private_EC2"
}

variable "priv_description" {
  type        = string
  default     = "Allow Private_EC2 Traffic"
}

variable "priv_description_ingr" {
  type        = string
  default     = "Private_EC2 Traffic Inbound"
}

variable "priv_ingr_sg" {
  type        = string
  default     = "[aws_security_group.Internal_LB.id]"
}


variable "dbms_sg_name" {
  description = "database sg"
  type        = string
  default     = "DBMS"
}


variable "dbms_des" {
  type        = string
  default     = "Allow DBMS Traffic"
}

variable "dbms_des_ingr" {
  type        = string
  default     = "DBMS Traffic Inbound"
}

variable "dbms_port" {
  type        = number
  default     = 3306
}


variable "dbms_ingr_sg" {
  type        = any
  default     = "[aws_security_group.Private_EC2.id]"
}

variable "bast_sg_name" {
  type        = string
  default     = "bastion_host"
}


variable "bast_des" {
  type        = string
  default     = "Allow SSH Traffic"
}

variable "bast_des_ingr" {
  type        = string
  default     = "Bastion_host Traffic Inbound"
}

variable "bash_ssh_port" {
  type        = number
  default     = 22
}

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

variable "profile_role"{
    type=string
    default="aws_iam_role.threetierrole.name"
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

variable "tar_grp_pri"{
    type=any
    default=["aws_lb_target_group.private_tg.arn"]
}

variable "tar_grp_pub"{
    type=any
    default=["aws_lb_target_group.public_tg.arn"]
}

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
    default="aws_subnet.public_sub_1.id"
}

variable "rds_sub_name" {
  type        = string
  default     = "rds_sub"
  description = "RDS Subnet Group Name"
}

variable "rds_sub_ids"{
    description="RDS Subnet Ids"
    type=list(string)
    default=["aws_subnet.private_sub_DB_1.id", "aws_subnet.private_sub_DB_2.id"]
}

variable "all_str"{
    type=number
    default=50
}

variable "max_all_str"{
    type=number
    default=100
}

variable "rds_engine"{
    type=string
    default="mysql"
}

variable "rds_engine_ver"{
    type=string
    default="5.7"
}

variable "multi_azs"{
    type=bool
    default=true
}

variable "rds_class"{
    description="RDS Instance Class"
    type=string
    default="db.t3.small"
}

variable "database_name"{
    type=string
    default="mydb"
}

variable "database_uname"{
    type=string
    default="admin"
}

variable "database_upasswd"{
    type=string
    default="abcd1234"
}

variable "vpc_sg"{
    description="VPC Security Group Ids"
    type=list(string)
    default=["aws_security_group.DBMS.id"]
}

variable "strg_enc"{
    type=bool
    default=true
}

variable "iam_auth"{
    type=bool
    default=true
}

variable "skip_final"{
    type=bool
    default=true
}