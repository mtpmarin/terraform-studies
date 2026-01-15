module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
  name       = "web-app-vpc"
}

module "subnets" {
  source         = "./modules/subnets"
  vpc_id         = module.vpc.vpc_id
  frontend_cidr  = "10.0.1.0/24"
  subnet_name_front = var.frontend_subnet_name

}

module "routing" {
  source              = "./modules/routing"
  vpc_id              = module.vpc.vpc_id
  frontend_subnet_id  = module.subnets.frontend_subnet_id
}

module "database" {
  source               = "./modules/database"
  identifier           = "web-db-instance"
  instance_type        = "db.t3.micro"
  db_username          = var.db_username
  db_password          = var.db_password
}

module "autoscaling_ec2" {
  source             = "./modules/autoscaling-ec2"
  name_prefix        = "web"
  image_id           = "ami-0fb0b230890ccd1e6"
  instance_type      = "t2.micro"
  autoscaling_name   = "web-app-asg"
  desired_capacity   = 1
  max                = 3
  min                = 1
  subnet_ids         = [module.subnets.frontend_subnet_id]
}