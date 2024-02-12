variable "TerraInstanceType" {

    type = string
    default = "t2.micro"
  
}

variable "terraInstance" {

    type = string
    default = "TerraSlave"
  
}

variable "AMI-ID" {

    default = "ami-0c7217cdde317cfec"
  
}

variable "securityGroup" {

    default = "Terra-slave-SG"
  
}