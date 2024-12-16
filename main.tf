resource "aws_security_group" "teja-test-sg" {
  name        = "teja-test-sg"
  description = "Security group with ingress and egress rules"

  # Ingress rules (inbound traffic)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.bank_cidrs # Allows SSH from anywhere; restrict as needed
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.bank_cidrs # Allows HTTP traffic
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.bank_cidrs # Allows HTTPS traffic
  }

  # Egress rules (outbound traffic)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"           # -1 allows all protocols
    cidr_blocks = var.bank_cidrs # Allows all outbound traffic
  }

  tags = {
    Name = "test-sg"
  }
}

