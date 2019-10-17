# Define the internet gateway for vpc 
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.default.id}"
  tags = {
    Name = "VPC IGW"
  }
}

# # nat gateway for nat server
# resource "aws_eip" "nat" {
#   vpc = true
#   instance = "${aws_instance.nat.id}"
#   tags = {
#     Name = "NAT-EIP"
#   }
# }
# resource "aws_nat_gateway" "ngw" {
#   allocation_id = "${aws_eip.nat.id}"
#   subnet_id = "${aws_subnet.public-subnets[1].id}"
#   depends_on = ["aws_internet_gateway.igw"]
#   tags = {
#     Name = "gw-NAT"
#   }
# }


