#ASG


resource "aws_launch_configuration" "private_lc" {
  name_prefix   = var.inst_name_pri
  image_id      = var.inst_imageid_pri
  instance_type = var.inst_type
  lifecycle {
    create_before_destroy = true
  }
 # depends_on = [aws_instance.private_ec2]
}

resource "aws_autoscaling_group" "internal_as" {
  name                 = var.asg_name_pri
  min_size             = var.min_size
  max_size             = var.max_size
  #availability_zones = ["us-east-1a","us-east-1b"]
  vpc_zone_identifier   = var.zone_ide_pri
  health_check_type = var.health_check
  health_check_grace_period = var.health_grace_per
  target_group_arns     = [aws_lb_target_group.private_tg.arn]
  launch_configuration = aws_launch_configuration.private_lc.name
  lifecycle {
    create_before_destroy = true
  }
 # depends_on = [aws_instance.private_ec2]
}

resource "aws_launch_configuration" "public_lc" {
  name_prefix   = var.inst_name_pub
  image_id     = var.inst_imageid_pub
  instance_type = var.inst_type
  associate_public_ip_address = var.public_ip
  lifecycle {
    create_before_destroy = true
  }
 # depends_on = [aws_instance.public_ec2]
}

resource "aws_autoscaling_group" "external_as" {
  name                 = var.asg_name_pub
  launch_configuration  = aws_launch_configuration.public_lc.name
  min_size             = var.min_size
  max_size             = var.max_size
  #availability_zones   = ["us-east-1a","us-east-1b"]
  vpc_zone_identifier   = var.zone_ide_pub
  health_check_type = var.health_check
  health_check_grace_period = var.health_grace_per
  target_group_arns     = [aws_lb_target_group.public_tg.arn]
  lifecycle {
    create_before_destroy = true
  }
 # depends_on = [aws_instance.public_ec2]
}


#Load Balancer


resource "aws_lb" "internal_lb" {
  name               = var.internal_name
  internal           = var.inter
  load_balancer_type = var.lb_type
  security_groups    = [var.intern_lb_sg]
  subnets            = var.intern_lb_sub
}

resource "aws_lb_target_group" "private_tg" {
  name     = var.intern_lb_tg_name
  port     = var.intern_lb_port
  protocol = var.intern_prot
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "private_tg_attach" {
  target_group_arn = aws_lb_target_group.private_tg.arn
  target_id        = var.intern_tg_id
  port             = var.intern_lb_port
  #depends_on       = [aws_instance.private_ec2]
}

resource "aws_lb" "external_lb" {
  name               = var.external_name
  internal           = var.exter
  load_balancer_type = var.lb_type
  security_groups    = [var.extern_lb_sg]
  subnets            = var.extern_lb_sub
}

resource "aws_lb_target_group" "public_tg" {
  name     = var.extern_lb_tg_name
  port     = var.intern_lb_port
  protocol = var.intern_prot
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "public_tg_attach" {
  target_group_arn = aws_lb_target_group.public_tg.arn
  target_id        = var.extern_tg_id
  port             = var.intern_lb_port
  #depends_on       = [aws_instance.public_ec2]
}

resource "aws_lb_listener" "external_elb" {
  load_balancer_arn = aws_lb.external_lb.arn
  port              = var.intern_lb_port
  protocol          = var.intern_prot

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.private_tg.arn
  }
}

resource "aws_lb_listener" "internal_elb" {
  load_balancer_arn = aws_lb.internal_lb.arn
  port              = var.intern_lb_port
  protocol          = var.intern_prot

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.public_tg.arn
  }
}