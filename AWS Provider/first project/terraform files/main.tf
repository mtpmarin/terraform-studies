module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
  name       = "web-app-vpc"
}

module "subnets" {
  source            = "./modules/subnets"
  vpc_id            = module.vpc.vpc_id
  frontend_cidr     = "10.0.1.0/24"
  subnet_name_front = var.frontend_subnet_name

}

module "routing" {
  source             = "./modules/routing"
  vpc_id             = module.vpc.vpc_id
  frontend_subnet_id = module.subnets.frontend_subnet_id
  allowed_cidr_blocks = ["0.0.0.0/0"]
}

module "database" {
  source        = "./modules/database"
  identifier    = "web-db-instance"
  instance_type = "db.t3.micro"
  db_username   = var.db_username
  db_password   = var.db_password
  private_subnets = [module.subnets.frontend_subnet_id]
  vpc_security_group_ids = [module.routing.rds_sg_id]
}

module "autoscaling_ec2" {
  source           = "./modules/autoscaling-ec2"
  name_prefix      = "web"
  image_id         = "ami-0fb0b230890ccd1e6"
  instance_type    = "t2.micro"
  autoscaling_name = "web-app-asg"
  desired_capacity = 1
  max              = 3
  min              = 1
  subnet_ids       = [module.subnets.frontend_subnet_id]
  target_group_arn = module.alb.target_group_arn
  security_group_id = module.routing.ec2_sg_id

}

module "alb" {
  source = "./modules/alb"
  alb_name = "web-app-alb"
  subnet_ids = [module.subnets.frontend_subnet_id]
  vpc_id = module.vpc.vpc_id
  security_group_ids = [module.routing.alb_sg_id]
}

module "cloudfront" {
  source          = "./modules/cloudfront"
  origin_domain   = module.alb.alb_dns_name
  origin_id       = "alb-origin"

}
