# Define webserver inside the public subnet
resource "aws_instance" "wb" {
   ami  = "${var.ami}"
   instance_type = "${var.inst_type}"
  #  key_name = "${aws_key_pair.default.id}"
   subnet_id = "${aws_subnet.public-subnets[0].id}"
   vpc_security_group_ids = ["${aws_security_group.sgfront.id}"]
   associate_public_ip_address = true
   user_data = "${file("./userdatas/userdata.sh")}"

  #  provisioner "remote-exec" {
  #   connection {
  #     type = "ssh"
  #     user = "ec2-user"
  #     private_key = "${file("~/.ssh/id_rsa")}"
  #     timeout = "5m"
  #     agent = true
  #   }

  #   inline = [
  #     "sudo apt-get update -y && apt-get upgrade -y",
  #     "sudo apt-get install nginx -y"
  #   ]
  # }

  tags = {
    Name = "webserver"
  }
}

resource "aws_instance" "nat" {
   ami = "${var.ami}"
   instance_type = "${var.inst_type}"
  #  key_name = "${aws_key_pair.default.id}"
   subnet_id = "${aws_subnet.public-subnets[1].id}"
   vpc_security_group_ids = ["${aws_security_group.sgfront.id}"]
   source_dest_check = false
  #  user_data = "${file("./userdatas/userdata.sh")}"

  tags = {
    Name = "Nat_server"
  }
}


output "dns_webserver" {
  value = "${aws_instance.wb.*.public_dns}"
}


# Define the security group for public subnet
resource "aws_security_group" "sgfront" {
  description = "web_test_sg Allow all"

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id="${aws_vpc.default.id}"

  tags = {
    Name = "Webserver SG"
  }
}