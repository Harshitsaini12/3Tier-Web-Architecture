resource "aws_iam_policy" "s3_policy" {
  name        = var.policy_name
  description = var.policy_des

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*",
          "s3-object-lambda:*"
        ]
        Effect   = "Allow"
        Resource = [

 "arn:aws:s3:::s3_policy/*" ]
      },
       {
            "Effect": "Allow",
            "Action": [
                "ssm:DescribeAssociation",
                "ssm:GetDeployablePatchSnapshotForInstance",
                "ssm:GetDocument",
                "ssm:DescribeDocument",
                "ssm:GetManifest",
                "ssm:GetParameter",
                "ssm:GetParameters",
                "ssm:ListAssociations",
                "ssm:ListInstanceAssociations",
                "ssm:PutInventory",
                "ssm:PutComplianceItems",
                "ssm:PutConfigurePackageResult",
                "ssm:UpdateAssociationStatus",
                "ssm:UpdateInstanceAssociationStatus",
                "ssm:UpdateInstanceInformation"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ssmmessages:CreateControlChannel",
                "ssmmessages:CreateDataChannel",
                "ssmmessages:OpenControlChannel",
                "ssmmessages:OpenDataChannel"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2messages:AcknowledgeMessage",
                "ec2messages:DeleteMessage",
                "ec2messages:FailMessage",
                "ec2messages:GetEndpoint",
                "ec2messages:GetMessages",
                "ec2messages:SendReply"
            ],
            "Resource": "*"
        }
    ]
  })
}

resource "aws_iam_role" "threetierrole" {
    name = var.role_name
    assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "RoleForEC2"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy_attachment" "policy_attach" {
  name       = var.policy_att
  roles      = [aws_iam_role.threetierrole.name]
  policy_arn = aws_iam_policy.s3_policy.arn
}

resource "aws_iam_instance_profile" "private_profile" {
  name = var.inst_prof
  role = aws_iam_role.threetierrole.name
}


resource "aws_instance" "private_ec2"{
    ami = data.aws_ami.aws_linux.id
    instance_type = var.inst_type
    key_name = var.key_name
    monitoring = var.monit_inst
    vpc_security_group_ids = [var.vpc_sg_pri]
    iam_instance_profile = aws_iam_instance_profile.private_profile.name
    subnet_id = var.pri_sub
    tags = {
    Terraform   = "true"
    Environment = "dev"
  }
    #user_data = file("install_mysql.sh")
}

resource "aws_instance" "public_ec2"{
    ami = data.aws_ami.aws_linux.id
    instance_type = var.inst_type
    key_name = var.key_name
    monitoring = var.monit_inst
    vpc_security_group_ids = [var.vpc_sg_pub]
    iam_instance_profile = aws_iam_instance_profile.private_profile.name
    subnet_id = var.pub_sub
    associate_public_ip_address = var.public_ip
    tags = {
    Terraform   = "true"
    Environment = "dev"
  }
    #user_data = file("install_nginx.sh")
    depends_on = [aws_instance.private_ec2]
}