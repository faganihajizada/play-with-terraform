# ---------------------------------------------------------------------------------------------------------------------
# Create VPC +, subnet +, elastic IP + and internet gateway +
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_vpc" "ingress" {
  cidr_block       = var.cidr-block

  tags = {
    Name = var.vpc-name
  }
}

resource "aws_subnet" "ingress-Subnet" {
  vpc_id     = aws_vpc.ingress.id
  cidr_block = var.cidr-block-subnet

  tags = {
    Name = var.subnet-name
  }
}

resource "aws_eip" "inress-eip" {
  instance = aws_instance.apache.id
  vpc      = true
}


resource "aws_internet_gateway" "ingress-gtw" {
  vpc_id = aws_vpc.ingress.id

  tags = {
    Name = var.igw-name
  }
}


# ---------------------------------------------------------------------------------------------------------------------
# Create route table and route table association
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_route_table" "rt-ingress" {
  vpc_id = aws_vpc.ingress.id

  route {
    cidr_block = var.cidr-block-rt
    gateway_id = aws_internet_gateway.ingress-gtw.id
  }

  tags = {
    Name = var.rt-name
  }
}

resource "aws_route_table_association" "rt-ingress-association" {
  subnet_id      = aws_subnet.ingress-Subnet.id
  route_table_id = aws_route_table.rt-ingress.id
}


# ---------------------------------------------------------------------------------------------------------------------
# Create security group
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "sgingress" {
  name        = var.sg-name
  description = var.sg-desc
  vpc_id      = aws_vpc.ingress.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from VPC"
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

  tags = {
    Name = var.sg-name
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# Create key_pair
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_key_pair" "terraform-key" {
  key_name   = var.key-name
  public_key = var.pub-key
}

# ---------------------------------------------------------------------------------------------------------------------
# Deploy a EC2 instance and install apache web server via EC2 user_data
# ---------------------------------------------------------------------------------------------------------------------


resource "aws_instance" "apache" {
  ami           = var.ami-id
  instance_type = var.intance-type
  vpc_security_group_ids = [aws_security_group.sgingress.id]
  subnet_id     = aws_subnet.ingress-Subnet.id
  key_name      = aws_key_pair.terraform-key.id
  user_data = <<-EOF
        #!/bin/bash
        # get root privileges
        sudo su
        # start and enable service
        systemctl start httpd service
        systemctl enable httpd service
        echo "httpd installed"
        echo "Dünyaya $(hostname -f) -dan Salam" >> /var/www/html/index.html
  EOF
  tags = {
    Name = var.instance-name
  }
}