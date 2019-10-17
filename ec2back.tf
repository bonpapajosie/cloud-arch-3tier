# Define database inside the private subnet
resource "aws_instance" "node1" {
   ami = "${var.ami}"
   instance_type = "${var.inst_type}"
  #  key_name = "${aws_key_pair.default.id}"

   subnet_id = "${aws_subnet.private-subnets[0].id}"
   vpc_security_group_ids = ["${aws_security_group.sgback.id}"]

  #  provisioner "remote-exec" {
  #   connection {
  #     type = "ssh"
  #     user = "ec2-user"
  #     # private_key = "${file("~/.ssh/id_rsa")}"
  #     timeout = "5m"
  #     agent = true
  #   }

  #   inline = [
  #     "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash",
  #     ". ~/.nvm/nvm.sh",
  #     "nvm install node"
  #   ]
  # }
  #  user_data = "${file("./userdatas/userdata.sh")}"

  tags = {
    Name = "node_server1"
  }
}

resource "aws_instance" "node2" {
   ami  = "${var.ami}"
   instance_type = "${var.inst_type}"
  #  key_name = "${aws_key_pair.default.id}"
   subnet_id = "${aws_subnet.private-subnets[1].id}"
   vpc_security_group_ids = ["${aws_security_group.sgback.id}"]

  tags = {
    Name = "node_server2"
  }
}


# Define the security group for private subnet
resource "aws_security_group" "sgback"{
  description = "Db_test_sg Allow traffic from public subnet"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.default.id}"

  tags = {
    Name = "Node server SG"
  }
}

