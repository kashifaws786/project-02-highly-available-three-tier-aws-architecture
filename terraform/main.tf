
# Retrieve the Availability Zones available in the selected AWS region.

data "aws_availability_zones" "available" {
  state = "available"
}

# Define common project settings.

locals {
  name_prefix = "${var.project_name}-${var.environment}"


  # Select two available Availability Zones.
  availability_zones = slice(
    data.aws_availability_zones.available.names,
    0,
    2
  )
}

# Retrieve the latest Amazon Linux 2023 AMI ID.

data "aws_ssm_parameter" "al2023_ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

# Deploy the reusable Network module.

module "network" {
  source = "./modules/network"

  name_prefix        = local.name_prefix
  availability_zones = local.availability_zones
}

# Deploy the reusable Security module.

module "security" {
  source = "./modules/security"

  name_prefix = local.name_prefix
  vpc_id      = module.network.vpc_id
}

# Deploy the reusable Compute module.

module "compute" {
  source = "./modules/compute"

  name_prefix           = local.name_prefix
  vpc_id                = module.network.vpc_id
  public_subnet_ids     = module.network.public_subnet_ids
  app_subnet_ids        = module.network.app_subnet_ids
  alb_security_group_id = module.security.alb_security_group_id
  app_security_group_id = module.security.app_security_group_id

  ami_id = data.aws_ssm_parameter.al2023_ami.value

  db_secret_arn = module.database.db_secret_arn

  aws_region = var.aws_region

  app_source_base64 = filebase64("${path.root}/../application/app.py")

  requirements_base64 = filebase64("${path.root}/../application/requirements.txt")
}


# Deploy the reusable Database module.

module "database" {
  source = "./modules/database"

  name_prefix       = local.name_prefix
  subnet_ids        = module.network.db_subnet_ids
  security_group_id = module.security.db_security_group_id

  db_name     = "appdb"
  db_username = var.db_username
}


# Deploy the reusable Monitoring module.

module "monitoring" {
  source = "./modules/monitoring"

  name_prefix = local.name_prefix
  aws_region  = var.aws_region

  # Connect CloudWatch to the Compute module.
  alb_arn_suffix          = module.compute.alb_arn_suffix
  target_group_arn_suffix = module.compute.target_group_arn_suffix
  autoscaling_group_name  = module.compute.autoscaling_group_name

  # Connect CloudWatch to the Database module.
  db_instance_id = module.database.db_instance_id
}
