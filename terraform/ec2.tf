resource "aws_key_pair" "deployer" {
  key_name   = "terra-automate-key"
  public_key = file("/Users/saurabh/Wanderlust-Mega-Project/terraform/terra-key.pub")
}

resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "project" {
    name = "project"
    description =  "Ingress-rule"  

    tags = {
      name = "Jenkins-SG"
    }

    dynamic "ingress" {
        for_each = var.sg_ports
        content {
          from_port = ingress.value.from
          to_port = ingress.value.to
          protocol = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
    }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "testinstance" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.allow_user_to_connect.name]
  tags = {
    Name = "Automate"
  }
  root_block_device {
    volume_size = 29 
    volume_type = "gp3"
  }
}
