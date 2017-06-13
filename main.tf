#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-a4f9f2c2
#
# Your subnet ID is:
#
#     subnet-7aba681d
#
# Your security group ID is:
#
#     sg-00100979
#
# Your Identity is:
#
#     hdays-michel-spider
#

variable aws_access_key {
  type = "string"
}

variable aws_secret_key {
  type = "string"
}

variable aws_region {
  default = "eu-west-1"
}

variable num_webs {
  default = "2"
}


terraform { 
	backend "atlas" {
	name = "bdennisb/training"
	}
}

#module "example" {
#	source = "./example-module"
#	command = "echo goodbye_world"
#}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  ami                    = "ami-a4f9f2c2"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-7aba681d"
  vpc_security_group_ids = ["sg-00100979"]
  count                  = "2"

  tags {
    "Identity" = "hdays-michel-spider"
    "testtag1" = "testingterraform"
    "testtag2" = "testingterraform2"
    "name"     = "web ${count.index+1}/${var.num_webs}"
  }
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}
