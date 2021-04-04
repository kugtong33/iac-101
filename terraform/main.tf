data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name = "virtualization-type"
    values = [
      "hvm"
    ]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_security_group" "firewall" {
  name = "firewall"

  ingress {
    description = "web traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ssh traffic"
    from_port   = 22
    to_port     = 22
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

resource "aws_instance" "personal_server" {
  ami = data.aws_ami.ubuntu.id

  instance_type = "t2.micro" # 1 vCPU 1 GB memory

  associate_public_ip_address = true

  ebs_block_device {
    delete_on_termination = true
    device_name           = "/dev/sda1"
    volume_size           = 20
    volume_type           = "gp3"
  }

  key_name = "aws-eb-hov"

  vpc_security_group_ids = [aws_security_group.firewall.id]

  tags = {
    Name = "personal-server"
  }
}