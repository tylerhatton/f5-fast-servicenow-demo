resource "random_password" "admin_password" {
  length  = 16
  special = false
}

data "aws_ami" "latest_f5_image" {
  most_recent = true
  owners      = ["679593333241"]

  filter {
    name   = "name"
    values = ["F5 BIGIP-16.1.0-0.0.19 PAYG-Good 25Mbps*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "template_file" "user_data" {
  template = file("${path.module}/templates/user_data.tpl")

  vars = {
    admin_password = random_password.admin_password.result
  }
}

resource "aws_instance" "f5_ltm" {
  ami                    = data.aws_ami.latest_f5_image.id
  instance_type          = var.instance_type
  key_name               = var.key_pair
  user_data              = data.template_file.user_data.rendered
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.f5_ltm.id]

  tags = merge(tomap({ "Name" = "${var.name_prefix}-F5_LTM" }), var.default_tags)
}

resource "aws_security_group" "f5_ltm" {
  name        = "${var.name_prefix}-bigip"
  description = "Allow inbound mgmt, http, and https traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8443
    to_port     = 8443
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
