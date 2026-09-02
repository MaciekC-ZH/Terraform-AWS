
# Security Group dla serwera WWW
resource "aws_security_group" "web_sg" {
  name        = "${var.server_name}-sg"
  description = "Dostep HTTP dla ${var.server_name}"

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

  tags = {
    Name        = "${var.server_name}-sg"
    Environment = var.environment
  }
}

# Instancja EC2 z wgranym Nginxem
resource "aws_instance" "web_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y nginx
              systemctl start nginx
              systemctl enable nginx
              echo "<h1>Witaj z modulu: ${var.server_name} (${var.environment})</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name        = var.server_name
    Environment = var.environment
  }
}
