resource "aws_instance" "bastion_host_1"{
  ami = data.aws_ami.aws_linux.id
  instance_type     = var.inst_type
  key_name = var.key_name
  monitoring = var.monit_inst
  vpc_security_group_ids = [var.bast_vpc_sg_pub]
  subnet_id = var.pub_sub_1
  associate_public_ip_address = var.public_ip
 # depends_on = [aws_instance.private_ec2]
}

resource "aws_instance" "bastion_host_2"{
  ami = data.aws_ami.aws_linux.id
  instance_type     = var.inst_type
  key_name = var.key_name
  monitoring = var.monit_inst
  vpc_security_group_ids = [var.bast_vpc_sg_pub]
  subnet_id = var.pub_sub_2
  associate_public_ip_address = var.public_ip
 # depends_on = [aws_autoscaling_group.internal_as]
}