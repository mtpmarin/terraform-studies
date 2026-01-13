module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
  name       = "web-app-vpc"
}

module "subnets" {
  source         = "./modules/subnets"
  vpc_id         = module.vpc.vpc_id
  frontend_cidr  = "10.0.1.0/24"
  backend_cidr   = "10.0.2.0/24"
  subnet_name_front = var.frontend_subnet_name
  subnet_name_back  = var.backend_subnet_name

}

module "routing" {
  source              = "./modules/routing"
  vpc_id              = module.vpc.vpc_id
  frontend_subnet_id  = module.subnets.frontend_subnet_id
  backend_subnet_id   = module.subnets.backend_subnet_id
}

module "database" {
  source               = "./modules/database"
  
  instance_type        = "db.t3.micro"
  db_username          = "admin"
  db_password          = var.db_password
  backend_subnet_ids   = [module.subnets.backend_subnet_id]
  backend_subnet_name  = var.backend_subnet_name
}