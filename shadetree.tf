provider "aws" {
  region = "us-west-1"
}

# Create a new security group
resource "aws_security_group" "shadetree_sg" {
  name_prefix = "SHADETREE_SG"
  
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["47.233.93.152/32"]
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["47.233.93.152/32"]
  }

  ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
    cidr_blocks = ["47.233.93.152/32"]
  }
}

# Launch a new EC2 instance
resource "aws_instance" "shadetree_dev" {
  ami           = "ami-0cbb9cf18672a427d"
  instance_type = "t2.micro"
  key_name      = "shadetree"
  vpc_security_group_ids = [aws_security_group.shadetree_sg.id]
  tags = {
    Name = "shadetree_dev"
  }
}