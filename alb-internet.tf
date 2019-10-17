#Provision load balancer
resource "aws_alb" "alb-web" {
  subnets         = [aws_subnet.public-subnets[0].id, aws_subnet.public-subnets[1].id]
  internal        = false
  security_groups = [aws_security_group.lb-internet.id, aws_security_group.sgfront.id]     
}

output "lb_eip" {
  value = aws_alb.alb-web.dns_name
}

resource "aws_alb_target_group" "webserver" {
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.default.id
}

resource "aws_alb_target_group_attachment" "frontendinst" {
  target_group_arn = aws_alb_target_group.webserver.arn
  target_id        = element(aws_instance.wb.*.id, count.index)
  port             = 8080
  count            = 2
}

resource "aws_alb_listener" "list-internet" {
  default_action {
    target_group_arn = aws_alb_target_group.webserver.arn
    type             = "forward"
  }
  load_balancer_arn = aws_alb.alb-web.arn
  port              = 80
}

resource "aws_security_group" "lb-internet" {
  name   = "lb-secgroup-internet"
  vpc_id = aws_vpc.default.id

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS access from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
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