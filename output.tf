output "outputofAMI-ID" {

    value = data.aws_ami.ubuntu-server
  
}

output "vpc_id" {

    value = data.aws_vpcs.default_vpc.ids
  
}