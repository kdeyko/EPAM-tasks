### Setting up provider
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

### Creating new VPC
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags {
    Name = "VPC-Final"
  }
}

### Creating private subnets
resource "aws_subnet" "subnet1" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${var.region}a"

  tags {
    Name = "Subnet1-Final"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${var.region}b"

  tags {
    Name = "Subnet2-Final"
  }
}

### Creating public subnets
resource "aws_subnet" "subnet3" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "10.0.3.0/24"
  availability_zone = "${var.region}a"

  tags {
    Name = "Subnet3-Final"
  }
}

resource "aws_subnet" "subnet4" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "10.0.4.0/24"
  availability_zone = "${var.region}b"

  tags {
    Name = "Subnet4-Final"
  }
}

### Create 2 EIPs for nat GWs
resource "aws_eip" "nat1-eip" {
  vpc = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_eip" "nat2-eip" {
  vpc = true

  lifecycle {
    create_before_destroy = true
  }
}

### Create 2 NAT GWs for private subnets
resource "aws_nat_gateway" "nat-gw1" {
  allocation_id = "${aws_eip.nat1-eip.id}"
  subnet_id     = "${aws_subnet.subnet3.id}"

  lifecycle {
    create_before_destroy = true
  }

  tags {
    Name = "NAT1-GW-Final"
  }
}

resource "aws_nat_gateway" "nat-gw2" {
  allocation_id = "${aws_eip.nat2-eip.id}"
  subnet_id     = "${aws_subnet.subnet4.id}"

  lifecycle {
    create_before_destroy = true
  }

  tags {
    Name = "NAT2-GW-Final"
  }
}

### Create an internet gateway for public subnet
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "IGW-Final"
  }
}

### Create public route table
resource "aws_route_table" "public-rt" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags {
    Name = "Public_RT-Final"
  }
}

### Public route association
resource "aws_route_table_association" "public-rt-assoc1" {
  subnet_id      = "${aws_subnet.subnet3.id}"
  route_table_id = "${aws_route_table.public-rt.id}"
}

resource "aws_route_table_association" "public-rt-assoc2" {
  subnet_id      = "${aws_subnet.subnet4.id}"
  route_table_id = "${aws_route_table.public-rt.id}"
}

### Create 2 RTs for NAT GWs
resource "aws_route_table" "nat-rt1" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat-gw1.id}"
  }

  tags {
    Name = "NAT-GW-RT1-Final"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table" "nat-rt2" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat-gw2.id}"
  }

  tags {
    Name = "NAT-GW-RT2-Final"
  }

  lifecycle {
    create_before_destroy = true
  }
}

### Prviate routes association
resource "aws_route_table_association" "private-rt-assoc1" {
  subnet_id      = "${aws_subnet.subnet1.id}"
  route_table_id = "${aws_route_table.nat-rt1.id}"
}

resource "aws_route_table_association" "private-rt-assoc2" {
  subnet_id      = "${aws_subnet.subnet2.id}"
  route_table_id = "${aws_route_table.nat-rt2.id}"
}

### Security group for ELB
resource "aws_security_group" "elb_sg" {
  name   = "ELB_SG-Final"
  vpc_id = "${aws_vpc.vpc.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

### Security group for instances (LC)
resource "aws_security_group" "lc_sg" {
  name   = "LC_SG-Final"
  vpc_id = "${aws_vpc.vpc.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH access from VPC
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
}

### A security group for the bastion instance
resource "aws_security_group" "bastion_sg" {
  name   = "Bastion_SG-Final"
  vpc_id = "${aws_vpc.vpc.id}"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

### Creating bastion instance
resource "aws_instance" "bastion" {
  ami                    = "${lookup(var.amis, var.region)}"
  instance_type          = "${var.instance_type}"
  subnet_id              = "${aws_subnet.subnet3.id}"
  vpc_security_group_ids = ["${aws_security_group.bastion_sg.id}"]
  key_name               = "${var.key_pair_name}"

  tags {
    Name = "Bastion"
  }
}

### Creating ans assigning EIP to bastion instance
resource "aws_eip" "ip" {
  instance = "${aws_instance.bastion.id}"
}

### Creating ELB
resource "aws_elb" "elb" {
  name            = "ELB-Final"
  subnets         = ["${aws_subnet.subnet3.id}", "${aws_subnet.subnet4.id}"]
  security_groups = ["${aws_security_group.elb_sg.id}"]

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:8080/"
  }

  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
}

### Creating Launch Configuration
resource "aws_launch_configuration" "lc" {
  name            = "LC-Final"
  image_id        = "${lookup(var.amis, var.region)}"
  instance_type   = "${var.instance_type}"
  key_name        = "${var.key_pair_name}"
  security_groups = ["${aws_security_group.lc_sg.id}"]

  user_data = "${file("userdata.sh")}"
}

### Creating ASG
resource "aws_autoscaling_group" "asg" {
  name                 = "ASG-Final"
  max_size             = "${var.asg_max}"
  min_size             = "${var.asg_min}"
  desired_capacity     = "${var.asg_desired}"
  health_check_type    = "ELB"
  force_delete         = true
  launch_configuration = "${aws_launch_configuration.lc.name}"
  vpc_zone_identifier  = ["${aws_subnet.subnet1.id}", "${aws_subnet.subnet2.id}"]
  load_balancers       = ["${aws_elb.elb.name}"]

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "TF-Final"
    propagate_at_launch = true
  }
}

### Creating S3 bucket
resource "aws_s3_bucket" "b" {
  bucket = "${var.bucket_name}"
  acl    = "public-read"

  website {
    index_document = "index.html"
  }
}

### Uploading image to our brand new bucket
resource "aws_s3_bucket_object" "img" {
  bucket = "${aws_s3_bucket.b.id}"
  key    = "${var.image_name}"
  source = "${var.image_name}"
  acl    = "public-read"
}

### Creating and uploading index.html web-page for static web hosting
resource "aws_s3_bucket_object" "index" {
  bucket = "${aws_s3_bucket.b.id}"
  key    = "index.html"

  content = <<-EOF
    <html>
    <head>
    <title>Awesome S3 WebPage</title>
    </head>
    <body>
 	<h1>Hey there!</h1>
 	</br>
 	<img src="${var.image_name}">
 	</body>
 	</html>
 EOF

  content_type = "text/html"
  acl          = "public-read"
}
