#Provision load balancer
resource "aws_alb" "alb-node" {
  subnets         = [aws_subnet.private-subnets[0].id, aws_subnet.private-subnets[1].id]
  internal        = true
  security_groups = [aws_security_group.lb-internal.id, aws_security_group.sgback.id]     
}

# output "lb_eip" {
#   value = aws_alb.alb-node.dns_name
# }

resource "aws_alb_target_group" "nodeservers" {
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.default.id
}

resource "aws_alb_target_group_attachment" "backendinstance1" {
  target_group_arn = aws_alb_target_group.nodeservers.arn
  target_id        = element(aws_instance.node1.*.id, count.index)
  port             = 8080
  count            = 1
}
resource "aws_alb_target_group_attachment" "backendinstance2" {
  target_group_arn = aws_alb_target_group.nodeservers.arn
  target_id        = element(aws_instance.node2.*.id, count.index)
  port             = 8080
  count            = 1
}

resource "aws_alb_listener" "list-internal" {
  default_action {
    target_group_arn = aws_alb_target_group.nodeservers.arn
    type             = "forward"
  }
  load_balancer_arn = aws_alb.alb-node.arn
  port              = 80
}

resource "aws_security_group" "lb-internal" {
  name   = "lb-secgroup-internal"
  vpc_id = aws_vpc.default.id

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ssh access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #ping from anywhere
  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}