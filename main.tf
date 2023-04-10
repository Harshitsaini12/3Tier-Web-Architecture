module "vpc" {
    source  = "./modules/VPC-Module"
    vpc_cidr=var.vpc_cidr
    az_1=var.az_1
    az_2=var.az_2
    pub_sub_cidr_1=var.pub_sub_cidr_1
    pri_sub_cidr_1=var.pri_sub_cidr_1
    pub_sub_cidr_2=var.pub_sub_cidr_2
    pri_sub_cidr_2=var.pri_sub_cidr_2
    pri_sub_cidr_3=var.pri_sub_cidr_3
    pri_sub_cidr_4=var.pri_sub_cidr_4
    route_table_cidr=var.route_table_cidr
    extern_sg_name=var.extern_sg_name
    extern_sg_des=var.extern_sg_des
    ing_from_to_port=var.ing_from_to_port
    egr_from_to_port=var.egr_from_to_port
    ingress_sg_protocol=var.ingress_sg_protocol
    egress_sg_protocol=var.egress_sg_protocol
    extern_cidr_sg=var.extern_cidr_sg
    self_ip=var.self_ip
    ipv6_cidr=var.ipv6_cidr
    intern_sg_name=var.intern_sg_name
    internal_description=var.internal_description
    internal_description_ingress=var.internal_description_ingress
    internal_cidr_blk=var.internal_cidr_blk
    intern_ingress_sg=var.intern_ingress_sg
    public_sg_name=var.public_sg_name
    public_sg_desc=var.public_sg_desc
    pub_ingr_sg=var.pub_ingr_sg
    private_sg_name=var.private_sg_name
    priv_description=var.priv_description
    priv_description_ingr=var.priv_description_ingr
    priv_ingr_sg=var.priv_ingr_sg
    dbms_sg_name=var.dbms_sg_name
    dbms_des=var.dbms_des
    dbms_des_ingr=var.dbms_des_ingr
    dbms_port=var.dbms_port
    dbms_ingr_sg=var.dbms_ingr_sg
    bast_sg_name=var.bast_sg_name
    bast_des=var.bast_des
    bast_des_ingr=var.bast_des_ingr
    bash_ssh_port=var.bash_ssh_port
}

module "EC2" {
    source  = "./modules/EC2-Module"
    policy_name=var.policy_name
    policy_des=var.policy_des
    role_name=var.role_name
    policy_att=var.policy_att
    inst_prof=var.inst_prof
    inst_type=var.inst_type
    key_name=var.key_name
    monit_inst=var.monit_inst
    vpc_sg_pri=module.vpc.Private_EC2_id
    vpc_sg_pub=module.vpc.Public_EC2_id
    pri_sub=module.vpc.pri_sub_1_id
    pub_sub=module.vpc.pub_sub_1_id
    public_ip=var.public_ip
}

module "ASG-LB" {
    source  = "./modules/ASG-LB-Module"
    inst_name_pri=var.inst_name_pri
    inst_name_pub=var.inst_name_pub
    inst_imageid_pri=module.EC2.pri_ec2_ami
    inst_imageid_pub=module.EC2.pub_ec2_ami
    inst_type=var.inst_type
    public_ip=var.public_ip
    asg_name_pri=var.asg_name_pri
    asg_name_pub=var.asg_name_pub
    min_size=var.min_size
    max_size=var.max_size
    zone_ide_pri=module.vpc.pri_sub_id
    zone_ide_pub=module.vpc.pub_sub_id
    health_check=var.health_check
    health_grace_per=var.health_grace_per
    #tar_grp_pri=var.tar_grp_pri
    #tar_grp_pub=var.tar_grp_pub

    #lb

    internal_name=var.internal_name
    inter=var.inter
    lb_type=var.lb_type
    intern_lb_sg=module.vpc.internal_lb_sg_id
    intern_lb_sub=module.vpc.intern_lb_sub_id
    intern_lb_tg_name=var.intern_lb_tg_name
    intern_lb_port=var.intern_lb_port
    intern_prot=var.intern_prot
    vpc_id=module.vpc.awsvpc_id
    intern_tg_id=module.EC2.pri_ec2_id
    external_name=var.external_name
    exter=var.exter
    extern_lb_sg=module.vpc.extern_lb_sg_id
    extern_lb_sub=module.vpc.extern_lb_sub_id
    extern_lb_tg_name=var.extern_lb_tg_name
    extern_tg_id=module.EC2.pub_ec2_id
}

module "jump-server" {
    source  = "./modules/jump-server"
    inst_type=var.inst_type
    key_name=var.key_name
    monit_inst=var.monit_inst
    bast_vpc_sg_pub=module.vpc.bast_sg
    pub_sub_1=module.vpc.pub_sub_1_id
    pub_sub_2=module.vpc.pub_sub_2_id
    public_ip=var.public_ip
}

module "RDS"{
    source  = "./modules/RDS"
    rds_sub_name=var.rds_sub_name
    rds_sub_ids=module.vpc.DB_sub_id
    all_str=var.all_str
    max_all_str=var.max_all_str
    rds_engine=var.rds_engine
    rds_engine_ver=var.rds_engine_ver
    multi_azs=var.multi_azs
    rds_class=var.rds_class
    database_name=var.database_name
    database_uname=var.database_uname
    database_upasswd=var.database_upasswd
    vpc_sg=[module.vpc.DB_sg_id]
    strg_enc=var.strg_enc
    iam_auth=var.iam_auth
    skip_final=var.skip_final
}