environment = "dev"
customer = "hcl"
project = "bayer"
region = "us-east-1"
cidr_block = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.3.0/24"]
private_subnet_cidrs = ["10.0.2.0/24", "10.0.4.0/24"]
public_azs = ["us-east-1a", "us-east-1b"]
private_azs = ["us-east-1a", "us-east-1b"]

patient_image_tag = "latest"
appointment_image_tag = "latest"

task_cpu = 512
task_memory = 1024
patient_container_port = 3000
appointment_container_port = 3001
desired_count = 1