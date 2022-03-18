# Create VPC
resource "aws_vpc" "lab_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "lab_vpc"
  }
}

# Create Subnet
resource "aws_subnet" "lab_vpc_subnet" {
  vpc_id                  = aws_vpc.lab_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = var.ec2_availability_zones
  map_public_ip_on_launch = true
}

# Create Internet Gateway
resource "aws_internet_gateway" "lab_vpc_ig" {
  vpc_id = aws_vpc.lab_vpc.id
}

# Create Route Table and Route
resource "aws_route_table" "lab_vpc_public_rt" {
  vpc_id = aws_vpc.lab_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lab_vpc_ig.id
  }
}

# Associate RT with Subnet
resource "aws_route_table_association" "lab_vpc_public_route_table_association" {
  route_table_id = aws_route_table.lab_vpc_public_rt.id
  subnet_id      = aws_subnet.lab_vpc_subnet.id
}

resource "aws_network_acl" "public" {
  vpc_id = aws_vpc.lab_vpc.id

  egress {
    rule_no    = 100
    action     = "allow"
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_block = "0.0.0.0/0"
  }

  ingress {
    rule_no    = 100
    action     = "allow"
    from_port  = 22
    to_port    = 22
    protocol   = "tcp"
    cidr_block = "0.0.0.0/0"
  }
  ingress {
    rule_no    = 200
    action     = "allow"
    from_port  = 80
    to_port    = 80
    protocol   = "tcp"
    cidr_block = "0.0.0.0/0"
  }
}


# Create security group
resource "aws_security_group" "lab_vpc_sg" {
  name        = "lab_vpc_sg"
  description = "Security group for lab VPC"
  vpc_id      = aws_vpc.lab_vpc.id

  ingress {
    description = "Open port 22 for SSH connections inbound"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Open port 80 for HTTP connections inbound"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Open all ports for outbound connection"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create EC2 Instance and attach it to the subnet
resource "aws_instance" "lab_vpc_ec2_instance" {
  ami                    = var.ec2_image_ami
  instance_type          = var.ec2_instance_type
  key_name               = var.ec2_instance_key
  subnet_id              = aws_subnet.lab_vpc_subnet.id
  vpc_security_group_ids = [aws_security_group.lab_vpc_sg.id]
  user_data              = file("./scripts/apache-install.sh")
  tags = {
    "Name" = "Lab_VPC_EC2_Instance"
  }
}

# Grab Elastic IP, depending on the gateway being provisioned
resource "aws_eip" "lab_vpc_eip" {
  instance = aws_instance.lab_vpc_ec2_instance.id
  vpc = true
  depends_on = [aws_internet_gateway.lab_vpc_ig]

}


