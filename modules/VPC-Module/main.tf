resource "aws_vpc" "threetiervpc"{
    #name="threetiervpc"
    cidr_block=var.vpc_cidr
}


resource "aws_subnet" "public_sub_1"{
    vpc_id=aws_vpc.threetiervpc.id
    cidr_block=var.pub_sub_cidr_1
    availability_zone=var.az_1
    tags = {
        Name = "Public Subnet AZ1"
    }
}


resource "aws_subnet" "private_sub_1"{
    vpc_id=aws_vpc.threetiervpc.id
    cidr_block=var.pri_sub_cidr_1
    availability_zone=var.az_1
    tags = {
        Name = "Private Subnet AZ1"
    }
}


resource "aws_subnet" "private_sub_DB_1"{
    vpc_id=aws_vpc.threetiervpc.id
    cidr_block=var.pri_sub_cidr_2
    availability_zone=var.az_1
    tags = {
        Name = "Private DB Subnet AZ1"
    }
}

resource "aws_subnet" "public_sub_2"{
    vpc_id=aws_vpc.threetiervpc.id
    cidr_block=var.pub_sub_cidr_2
    availability_zone=var.az_2
    tags = {
        Name = "Public Subnet AZ1"
    }
}
resource "aws_subnet" "private_sub_2"{
    vpc_id=aws_vpc.threetiervpc.id
    cidr_block=var.pri_sub_cidr_3
    availability_zone=var.az_2
    tags = {
        Name = "Private Subnet AZ1"
    }
}
resource "aws_subnet" "private_sub_DB_2"{
    vpc_id=aws_vpc.threetiervpc.id
    cidr_block=var.pri_sub_cidr_4
    availability_zone=var.az_2
    tags = {
        Name = "Private DB Subnet AZ1"
    }
}

resource "aws_eip" "eip" {
  vpc      = true
}

resource "aws_eip" "eip_1" {
  vpc      = true
}

resource "aws_internet_gateway" "igw_threetier" {
  vpc_id = aws_vpc.threetiervpc.id

  tags = {
    Name = "main"
  }
}


resource "aws_nat_gateway" "nat_gat_1" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_sub_1.id
  tags = {
    Name = "nat_gat_1"
  }
  depends_on = [aws_internet_gateway.igw_threetier]
}

resource "aws_nat_gateway" "nat_gat_2" {
  allocation_id = aws_eip.eip_1.id
  subnet_id     = aws_subnet.public_sub_2.id

  tags = {
    Name = "nat_gat_2"
  }
  depends_on = [aws_internet_gateway.igw_threetier]
}


resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.threetiervpc.id
  route {
    cidr_block = var.route_table_cidr
    gateway_id = aws_internet_gateway.igw_threetier.id
  }
  tags = {
    Name = "Public RT"
  }
}

resource "aws_route_table" "private_nat_rt" {
  vpc_id = aws_vpc.threetiervpc.id
  route {
    cidr_block = var.route_table_cidr
    gateway_id = aws_nat_gateway.nat_gat_1.id
  }
  tags = {
    Name = "Private Sub RT"
  }
}

resource "aws_route_table" "private_nat_rt_1" {
  vpc_id = aws_vpc.threetiervpc.id
  route {
    cidr_block = var.route_table_cidr
    gateway_id = aws_nat_gateway.nat_gat_2.id
  }
  tags = {
    Name = "Private Sub RT"
  }
}

resource "aws_route_table_association" "public_sub_assoc" {
  subnet_id      = aws_subnet.public_sub_1.id
  #gateway_id     = aws_internet_gateway.igw_threetier.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_sub_assoc_1" {
  subnet_id      = aws_subnet.public_sub_2.id
  #gateway_id     = aws_internet_gateway.igw_threetier.id
  route_table_id = aws_route_table.public_rt.id
}


resource "aws_route_table_association" "priv_sub_assoc" {
  subnet_id      = aws_subnet.private_sub_1.id
  #gateway_id     = aws_nat_gateway.nat_gat_1.id
  route_table_id = aws_route_table.private_nat_rt.id
}

resource "aws_route_table_association" "priv_sub_assoc_1" {
  subnet_id      = aws_subnet.private_sub_2.id
  #gateway_id     = aws_nat_gateway.nat_gat_2.id
  route_table_id = aws_route_table.private_nat_rt_1.id
}

resource "aws_security_group" "External_LB" {
  name        = var.extern_sg_name
  description = var.extern_sg_des
  vpc_id      = aws_vpc.threetiervpc.id

  ingress {
    description      = var.extern_sg_des
    from_port        = var.ing_from_to_port
    to_port          = var.ing_from_to_port
    protocol         = var.ingress_sg_protocol
    cidr_blocks      = [var.route_table_cidr]
    self             = var.self_ip
  }

  egress {
    from_port        = var.egr_from_to_port
    to_port          = var.egr_from_to_port
    protocol         = var.egress_sg_protocol
    cidr_blocks      = [var.route_table_cidr]
   # ipv6_cidr_blocks = [var.ipv6_cidr]
  }

  tags = {
    Name = "External_LB"
  }
  depends_on = [aws_vpc.threetiervpc]
}

resource "aws_security_group" "Internal_LB" {
  name        = var.intern_sg_name
  description = var.internal_description
  vpc_id      = aws_vpc.threetiervpc.id

  ingress {
    description      = var.internal_description_ingress
    from_port        = var.ing_from_to_port
    to_port          = var.ing_from_to_port
    protocol         = var.ingress_sg_protocol
    cidr_blocks      = [aws_vpc.threetiervpc.cidr_block]
    #security_groups  = [var.intern_ingress_sg]
    self             = var.self_ip
  }
  egress {
    from_port        = var.egr_from_to_port
    to_port          = var.egr_from_to_port
    protocol         = var.egress_sg_protocol
    cidr_blocks      = [var.route_table_cidr]
   # ipv6_cidr_blocks = [var.ipv6_cidr]
  }

  tags = {
    Name = "Internal_LB"
  }
  depends_on = [aws_vpc.threetiervpc]
}

resource "aws_security_group" "Public_EC2" {
  name        = var.public_sg_name
  description = var.public_sg_desc
  vpc_id      = aws_vpc.threetiervpc.id

  ingress {
    description      = var.public_sg_desc_ingr
    from_port        = var.ing_from_to_port
    to_port          = var.ing_from_to_port
    protocol         = var.ingress_sg_protocol
    cidr_blocks      = [aws_vpc.threetiervpc.cidr_block]
    #security_groups  = [var.pub_ingr_sg]
  }

  egress {
    from_port        = var.egr_from_to_port
    to_port          = var.egr_from_to_port
    protocol         = var.egress_sg_protocol
    cidr_blocks      = [var.route_table_cidr]
   # ipv6_cidr_blocks = [var.ipv6_cidr]
  }

  tags = {
    Name = "Public_EC2"
  }
  depends_on = [aws_vpc.threetiervpc]
}

resource "aws_security_group" "Private_EC2" {
  name        = var.private_sg_name
  description = var.priv_description
  vpc_id      = aws_vpc.threetiervpc.id
  ingress {
    description      = var.priv_description_ingr
    from_port        = var.ing_from_to_port
    to_port          = var.ing_from_to_port
    protocol         = var.ingress_sg_protocol
    cidr_blocks      = [aws_vpc.threetiervpc.cidr_block]
    #security_groups  = [var.priv_ingr_sg]
    self             = var.self_ip
  }
  egress {
    from_port        = var.egr_from_to_port
    to_port          = var.egr_from_to_port
    protocol         = var.egress_sg_protocol
    cidr_blocks      = [var.route_table_cidr]
   # ipv6_cidr_blocks = [var.ipv6_cidr]
  }

  tags = {
    Name = "Private_EC2"
  }
  depends_on = [aws_vpc.threetiervpc]
}

resource "aws_security_group" "DBMS" {
  name        = var.dbms_sg_name
  description = var.dbms_des
  vpc_id      = aws_vpc.threetiervpc.id

  ingress {
    description      = var.dbms_des_ingr
    from_port        = var.dbms_port
    to_port          = var.dbms_port
    protocol         = var.ingress_sg_protocol
    cidr_blocks      = [aws_vpc.threetiervpc.cidr_block]
    #security_groups  = [var.dbms_ingr_sg]
    self             = var.self_ip
  }
  egress {
    from_port        = var.egr_from_to_port
    to_port          = var.egr_from_to_port
    protocol         = var.egress_sg_protocol
    cidr_blocks      = [var.route_table_cidr]
    #ipv6_cidr_blocks = [var.ipv6_cidr]
  }

  tags = {
    Name = "DBMS"
  }
  depends_on = [aws_vpc.threetiervpc]
}

resource "aws_security_group" "bastion_host_sg" {
  name        = var.bast_sg_name
  description = var.bast_des
  vpc_id      = aws_vpc.threetiervpc.id

  ingress {
    description      = var.bast_des_ingr
    from_port        = var.bash_ssh_port
    to_port          = var.bash_ssh_port
    protocol         = var.ingress_sg_protocol
    cidr_blocks      = [aws_vpc.threetiervpc.cidr_block]
    self             = var.self_ip
  }

  egress {
    from_port        = var.egr_from_to_port
    to_port          = var.egr_from_to_port
    protocol         = var.egress_sg_protocol
    cidr_blocks      = [var.route_table_cidr]
   # ipv6_cidr_blocks = [var.ipv6_cidr]
  }

  tags = {
    Name = "bastion_host_sg"
  }
  depends_on = [aws_vpc.threetiervpc]
}