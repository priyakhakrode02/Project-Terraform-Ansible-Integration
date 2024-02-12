data "aws_ami" "ubuntu-server" {

    most_recent = true
    owners = ["099720109477"]

    filter {
      
       name = "name"
       values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20231207"]
    }
  
}

data "aws_vpcs" "default_vpc" {
  
}