data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "nginx" {
  count                  = var.instance_count
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.small"
  key_name               = var.key_pair
  user_data              = file("${path.module}/scripts/nginx.sh")
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.nginx.id]

  tags = merge(tomap({ "Name" = "${var.name_prefix}-nginx-${count.index}" }), var.default_tags)
}

resource "aws_security_group" "nginx" {
  name   = "${var.name_prefix}-nginx"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
