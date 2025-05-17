#This is the main Terraform file where we tie everything together.

module "vpc" {
  source       = "./modules/vpc"
  region       = var.region
  cidr_block   = var.cidr_block
  customer     = var.customer
  project      = var.project
  environment  = var.environment
  pub_sub_cidr = var.pub_sub_cidr
  pri_sub_cidr = var.pri_sub_cidr
  public_az    = var.public_az
  private_az   = var.private_az
}

module "security_groups" {
  source      = "./modules/sg"
  vpc_id      = module.vpc.vpc_id
  customer    = var.customer
  project     = var.project
  environment = var.environment
}

module "ecr" {
  source      = "./modules/ecr"
  customer    = var.customer
  project     = var.project
  environment = var.environment
}

module "iam" {
  source      = "./modules/iam"
  customer    = var.customer
  project     = var.project
  environment = var.environment
}

module "cloudwatch" {
  source      = "./modules/cloudwatch"
  customer    = var.customer
  project     = var.project
  environment = var.environment
}

module "ecs" {
  source                     = "./modules/ecs"
  region                     = var.region
  environment                = var.environment
  project                    = var.project
  customer                   = var.customer
  vpc_id                     = module.vpc.vpc_id
  private_subnet             = module.vpc.private_subnet_id
  task_cpu                   = var.task_cpu
  task_memory                = var.task_memory
  patient_container_port     = var.patient_container_port
  appointment_container_port = var.appointment_container_port
  desired_count              = var.desired_count
  patient_image              = "${module.ecr.patient_repository_url}:${var.patient_image_tag}"
  appointment_image          = "${module.ecr.appointment_repository_url}:${var.appointment_image_tag}"
  execution_role_arn         = module.iam.ecs_execution_role_arn
  alb_security_group_id      = module.security_groups.alb_security_group_id
  ecs_security_group_id      = module.security_groups.ecs_security_group_id
  patient_log_group_name     = module.cloudwatch.patient_log_group_name
  appointment_log_group_name = module.cloudwatch.appointment_log_group_name
}

module "alb" {
  source                       = "./modules/alb"
  customer                     = var.customer
  project                      = var.project
  environment                  = var.environment
  vpc_id                       = module.vpc.vpc_id
  public_subnet_id             = module.vpc.public_subnet_id
  alb_security_group_id        = module.security_groups.alb_security_group_id
  patient_target_group_arn     = module.ecs.patient_target_group_arn
  appointment_target_group_arn = module.ecs.appointment_target_group_arn
}

