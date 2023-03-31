
resource "aws_instance" "app" {
  ami                         = var.ec2_details.ami_id
  associate_public_ip_address = true
  instance_type = var.ec2_details.instance_type
  tags = {
    Name = "Ec2_app"
  }
}