resource "aws_instance" "bastion-host" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.ssh_key_bastion
  subnet_id                   = var.subnet_ids[0]
  vpc_security_group_ids      = aws_security_group.sg-bastion[*].id
  associate_public_ip_address = true

  root_block_device {
    volume_size           = 30
    delete_on_termination = true
  }

  tags = {
    Name        = "${var.env}-${var.project_name}-bastion"
    Environment = "${var.env}"
    Management  = "terraform"
  }
}

resource "aws_eip" "bastion_eip" {

  tags = {
    Name        = "${var.env}-${var.project_name}-bastion"
    Environment = "${var.env}"
    Management  = "terraform"
  }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.bastion-host.id
  allocation_id = aws_eip.bastion_eip.id
}

resource "aws_security_group" "sg-bastion" {
  name        = "${var.env}-${var.project_name}-bastion-sg"
  description = "BASTION Security Group"
  vpc_id      = var.vpc_id

  ingress = [
    {
      description      = "SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = var.cidr_ingress
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null
      security_groups  = var.sg_ingress
      self             = null
    }
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      description      = null
      prefix_list_ids  = null
      security_groups  = null
      self             = null

    }
  ]

  tags = {
    Name        = "${var.env}-${var.project_name}-bastion-sg"
    Environment = "${var.env}"
    Management  = "terraform"
  }
}
