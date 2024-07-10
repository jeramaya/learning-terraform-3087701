variable "instance_type" {
  description = "Type of EC2 instance to provision"
  default     = "t3.nano"
}


variable "ami_filter" {
  description = "name filter and owner for AMI"

  type = object({
    name  = string
    owner = string
  })
    default = {
    name  = "bitnami-tomcat-*-x86_64-hvm-ebs-nami"
    owner = "979382823631" #Bitnami
    }
  }


data "aws_vpc" "default"{
default = true
}

variable "environment"{
  description = "Development Environment"

  type = object ({
    name = string
    network_prefix = string
  })
  default = {
  name = "dev"
  network_prefix = "10.0"
  }
}

resource "aws_instance" "blog" {
  ami           = data.aws_ami.app_ami.id
  instance_type = var.instance_type

vpc_security_group_ids = [module.blog_sg.security_group_id]

  subnet_id = module.blog_vpc.public_subnets[0]


  tags = {
    Name = "Learing Terraform"
  }
}

variable"asg_min_size"{
  description = " Minimum number of instances in the ASG"
 default           = 1
}

variable"asg_max_size"{
  description = " Maximum number of instances in the ASG"
 default           = 2
}
