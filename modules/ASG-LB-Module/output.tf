output "pri_tg_arn"{
    value=aws_lb_target_group.private_tg.arn
}

output "pub_tg_arn"{
    value=aws_lb_target_group.public_tg.arn
}