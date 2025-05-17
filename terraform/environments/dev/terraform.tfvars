environment = "dev"
customer = "hcl"
project = "bayer"
region = "us-east-1"
cidr_block = "10.0.0.0/16"
pub_sub_cidr = "10.0.1.0/24"
pri_sub_cidr =  "10.0.2.0/24"
public_az = "us-east-1a"
private_az = "us-east-1b"

patient_image_tag = "latest"
appointment_image_tag = "latest"

task_cpu = 512
task_memory = 1024
patient_container_port = 3000
appointment_container_port = 3001
desired_count = 1