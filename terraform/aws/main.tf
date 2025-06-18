# Get the latest Ubuntu 22.04 ARM AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-arm64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_vpc" "nomad_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "nomad-vpc"
  }
}

resource "aws_subnet" "nomad_subnet" {
  vpc_id                  = aws_vpc.nomad_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "nomad-subnet"
  }
}

resource "aws_internet_gateway" "nomad_igw" {
  vpc_id = aws_vpc.nomad_vpc.id

  tags = {
    Name = "nomad-igw"
  }
}

resource "aws_route_table" "nomad_rt" {
  vpc_id = aws_vpc.nomad_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nomad_igw.id
  }

  tags = {
    Name = "nomad-rt"
  }
}

resource "aws_route_table_association" "nomad_rta" {
  subnet_id      = aws_subnet.nomad_subnet.id
  route_table_id = aws_route_table.nomad_rt.id
}

resource "aws_key_pair" "nomad_key" {
  key_name   = "nomad-server-key"
  public_key = file("${path.module}/nomad-prod.pub")
}

resource "aws_security_group" "nomad_sg" {
  name        = "nomad-server-sg"
  description = "Security group for Nomad server"
  vpc_id      = aws_vpc.nomad_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 4646
    to_port     = 4646
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 4647
    to_port     = 4647
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 4648
    to_port     = 4648
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

resource "aws_spot_instance_request" "nomad_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  spot_type              = "persistent"
  spot_price             = "0.0085"
  wait_for_fulfillment   = true
  key_name               = aws_key_pair.nomad_key.key_name
  vpc_security_group_ids = [aws_security_group.nomad_sg.id]
  subnet_id              = aws_subnet.nomad_subnet.id

  tags = {
    Name = var.instance_name
  }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get upgrade -y
              apt-get install -y apt-transport-https ca-certificates curl software-properties-common
              curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
              add-apt-repository "deb [arch=arm64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
              apt-get update
              apt-get install -y docker-ce docker-ce-cli containerd.io
              curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
              apt-add-repository "deb [arch=arm64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
              apt-get update
              apt-get install -y nomad
              cat > /etc/nomad.d/server.hcl <<'NOMADCONF'
              data_dir = "/opt/nomad/data"
              bind_addr = "0.0.0.0"
              server {
                enabled = true
                bootstrap_expect = 1
              }
              ports {
                http = 4646
                rpc  = 4647
                serf = 4648
              }
              NOMADCONF
              systemctl enable nomad
              systemctl start nomad
              apt-get install -y awscli
              cat > /usr/local/bin/check-spot-status.sh <<'SCRIPT'
              #!/bin/bash
              INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
              SPOT_STATUS=$(aws ec2 describe-spot-instance-requests --filters "Name=instance-id,Values=$INSTANCE_ID" --query 'SpotInstanceRequests[0].Status.Code' --output text)
              if [ "$SPOT_STATUS" = "marked-for-termination" ]; then
                  systemctl stop nomad
                  sleep 30
                  shutdown -h now
              fi
              SCRIPT
              chmod +x /usr/local/bin/check-spot-status.sh
              (crontab -l 2>/dev/null; echo "*/5 * * * * /usr/local/bin/check-spot-status.sh") | crontab -
              EOF
}

resource "null_resource" "spot_termination_handler" {
  triggers = {
    instance_id = aws_spot_instance_request.nomad_server.spot_instance_id
  }

  provisioner "local-exec" {
    command = <<-EOF
      export AWS_REGION=${var.aws_region}
      aws ec2 wait spot-instance-request-fulfilled --spot-instance-request-ids ${aws_spot_instance_request.nomad_server.id}
      echo "Spot instance ${aws_spot_instance_request.nomad_server.spot_instance_id} is running"
    EOF
  }
}