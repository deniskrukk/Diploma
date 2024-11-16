# // Provider
# provider "aws" {
#     region     = "eu-north-1"
#     access_key = var.aws_access_key
#     secret_key = var.aws_secret_key 
# }

# resource "aws_instance" "EC2-instance" {
#     availability_zone = "eu-north-1a"
#     ami = "ami-08eb150f611ca277f"
#     instance_type = "t3.medium"
#     key_name = "Stockholm"
#     vpc_security_group_ids = [aws_security_group.DefaultTerraformSG.id]

#     ebs_block_device {
#       device_name = "/dev/sda1"
#       volume_size = 15
#       tags = {
#         "name" = "root disk"
#       }
#     }

#     tags = {
#       Name = "Jenkins"
#     }
  
#   user_data = file("files/install.sh")
# }

# // Create security group
# resource "aws_security_group" "DefaultTerraformSG" {
#   name        = "DefaultTerraformSG"
#   description = "Allow 22, 80, 443, and 8080 inbound traffic"

#   // Define the ingress rules as a map
#   dynamic "ingress" {
#     for_each = {
#       "http" = { from_port = 8080, to_port = 8080 },
#       "ssh" = { from_port = 22, to_port = 22 }
#     }

#     content {
#       description = ingress.key
#       from_port   = ingress.value.from_port
#       to_port     = ingress.value.to_port
#       protocol    = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#     }
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

// Provider
provider "aws" {
    region     = "eu-north-1"
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key 
}

resource "aws_instance" "EC2-instance" {
    availability_zone = "eu-north-1a"
    ami = "ami-08eb150f611ca277f"
    instance_type = "t3.medium"
    key_name = "Stockholm_2"
    vpc_security_group_ids = [aws_security_group.DefaultTerraformSG.id]

    ebs_block_device {
      device_name = "/dev/sda1"
      volume_size = 30
      tags = {
        "name" = "root disk"
      }
    }

    tags = {
      Name = "Jenkins"
    }
  
  user_data = file("files/install_jenkins.sh")
}

// Create security group
resource "aws_security_group" "DefaultTerraformSG" {
  name        = "DefaultTerraformSG"
  description = "Allow 22, 80, 443, and 8080 inbound traffic"

  // Define the ingress rules as a map
  dynamic "ingress" {
    for_each = {
      "http"    = { from_port = 80, to_port = 80, description = "Allow HTTP" }
      "https"   = { from_port = 443, to_port = 443, description = "Allow HTTPS" }
      "jenkins" = { from_port = 8080, to_port = 8080, description = "Allow Jenkins" }
      "mssql"   = { from_port = 1433, to_port = 1433, description = "Allow MSSQL" }
      "backend" = { from_port = 5034, to_port = 5034, description = "Allow Backend" }
      "ssh"     = { from_port = 22, to_port = 22, description = "Allow SSH" }
    }

    content {
      description = ingress.key
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = "tcp"
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