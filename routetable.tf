# Define the route table public server 
resource "aws_route_table" "web-public-rt" {
  vpc_id = "${aws_vpc.default.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
  tags = {
    Name = "WEB-PUBLIC RT"
  }
}
# & Assign to webserver
resource "aws_route_table_association" "web-public-rt" {
  subnet_id = "${aws_subnet.public-subnets[0].id}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}


# # Define the route private nat table
# # & Assign to the nat-server
# resource "aws_route_table" "nat-node" {
#   vpc_id = "${aws_vpc.default.id}"
#   route {
#     cidr_block = "${aws_vpc.default.cidr_block}"
#     gateway_id = "${aws_nat_gateway.ngw.id}"
#   }
#   tags = {
#     Name = "NAT-NODE RT"
#   }
# }
# resource "aws_route_table_association" "nat-node" {
#   subnet_id = "${aws_subnet.private-subnets[0].id}"
#   route_table_id = "${aws_route_table.nat-node.id}"
# }

