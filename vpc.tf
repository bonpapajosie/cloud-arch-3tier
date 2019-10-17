resource "aws_vpc" "default" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-3tier"
  }
}

#creation of "2" public subnets
resource "aws_subnet" "public-subnets" {
  count = 2
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${element(var.public_subnet_cidrs, count.index)}"
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "Public-subnet-${count.index + 1}"
  }
}
#creation of "2" private subnets
resource "aws_subnet" "private-subnets" {
  count = 2
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${element(var.private_subnet_cidrs, count.index)}"
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "Private-subnet-${count.index + 1}"
  }
}
