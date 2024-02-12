terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.31"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my-instance" {

    instance_type = var.TerraInstanceType
    ami = data.aws_ami.ubuntu-server.id

    tags = {
      
      Name = "terra-slave"
    }

    key_name = aws_key_pair.my-key-pair.key_name
    vpc_security_group_ids = [aws_security_group.my-security-group.id]
  
}

resource "aws_key_pair" "my-key-pair" {

    key_name = "terra-slave-key"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
}

resource "aws_security_group" "my-security-group" {

    name = var.securityGroup
    description = "terraform slave SG"
    vpc_id = data.aws_vpcs.default_vpc.ids[0]

ingress {

  description = "SSH"
  from_port   =  22
  to_port     =  22
  protocol    =  "tcp"
  cidr_blocks =   ["0.0.0.0/0"]

}

ingress {

  description   = "HTTP"
  from_port     = 80
  to_port       = 80
  protocol      = "tcp"
  cidr_blocks   = ["0.0.0.0/0"]

}

egress {

  from_port        = 0
  to_port          = 0
  protocol         = "-1"
  cidr_blocks      = ["0.0.0.0/0"]


}
  
}

resource "null_resource" "ConfigureAnsibleInventory" {

  triggers = {
       MyTrigger = timestamp() 
  }

  provisioner "local-exec" {

       command = "echo [prod] > inventory"
    
  }
  provisioner "local-exec" {

    command = "echo ${aws_instance.my-instance.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=  >> inventory"
    
  }
  
}



  

