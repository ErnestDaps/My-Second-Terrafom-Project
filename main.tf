
# Creating networkinf for the project in EU-west-1
resource "aws_vpc" "Eng_Daps" {
  cidr_block           = var.VPC-cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "Eng_vpc_Daps"
  }

}

# Public Subnet 1 
resource "aws_subnet" "prod_Pub_Sub1" {
  vpc_id            = aws_vpc.Eng_Daps.id
  cidr_block        = var.public-sub1-cidr
  availability_zone = var.AZ1

  tags = {
    Name = "prod -Pub-Sub1"
  }

}

# Public Subnet 2 
resource "aws_subnet" "prod_Public_Sub2" {
  vpc_id            = aws_vpc.Eng_Daps.id
  cidr_block        = var.public-sub2-cidr
  availability_zone = var.AZ1

  tags = {
    Name = "prod-Public-Sub2"
  }

}

# Public Subnet 3 
resource "aws_subnet" "prod_Pub_Sub2" {
  vpc_id            = aws_vpc.Eng_Daps.id
  cidr_block        = var.public-sub3-cidr
  availability_zone = var.AZ2

  tags = {
    Name = "prod -Pub-Sub2"
  }

}

# Private Subnet 1 
resource "aws_subnet" "Prod_priv_Sub1" {
  vpc_id            = aws_vpc.Eng_Daps.id
  cidr_block        = var.private-sub1-cidr
  availability_zone = var.AZ1

  tags = {
    Name = "Prod-priv-Sub1"
  }

}

# Private Subnet 2 

resource "aws_subnet" "Prod_priv_Sub2" {
  vpc_id            = aws_vpc.Eng_Daps.id
  cidr_block        = var.private-sub2-cidr
  availability_zone = var.AZ2

  tags = {
    Name = "Prod-priv-Sub2"
  }

}

# Public Route table 

resource "aws_route_table" "prod_pub_route_table" {
  vpc_id = aws_vpc.Eng_Daps.id

  tags = {
    Name = "prod-pub-route-table"
  }

}

# Private Route table 

resource "aws_route_table" "prod_priv_route_table" {
  vpc_id = aws_vpc.Eng_Daps.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.Prod_Nat_gateway.id
  }

  tags = {
    Name = "prod-priv-route-table"
  }

}

# Associate public subnets with the public route table 

resource "aws_route_table_association" "pub_sub1_route_assoc" {
  subnet_id      = aws_subnet.prod_Pub_Sub1.id
  route_table_id = aws_route_table.prod_pub_route_table.id
}

resource "aws_route_table_association" "pub_sub2_route_assoc" {
  subnet_id      = aws_subnet.prod_Public_Sub2.id
  route_table_id = aws_route_table.prod_pub_route_table.id
}

resource "aws_route_table_association" "pub_sub3_route_assoc" {
  subnet_id      = aws_subnet.prod_Pub_Sub2.id
  route_table_id = aws_route_table.prod_pub_route_table.id
}

# Associate private subnets with the private route table 
resource "aws_route_table_association" "priv_sub1_route_assoc" {
  subnet_id      = aws_subnet.Prod_priv_Sub1.id
  route_table_id = aws_route_table.prod_priv_route_table.id
}

resource "aws_route_table_association" "priv_sub2_route_assoc" {
  subnet_id      = aws_subnet.Prod_priv_Sub2.id
  route_table_id = aws_route_table.prod_priv_route_table.id
}

# Internet Gateway 

resource "aws_internet_gateway" "prod_igw" {
  vpc_id = aws_vpc.Eng_Daps.id

  tags = {
    Name = "prod-igw"
  }

}

# Associate the internet gateway to the public route table 

resource "aws_route" "Daps_IGW_route_assoc" {
  route_table_id         = aws_route_table.prod_pub_route_table.id
  gateway_id             = aws_internet_gateway.prod_igw.id
  destination_cidr_block = "0.0.0.0/0"
}

# Allocate elastic ip address for the Nat gateway
resource "aws_eip" "eip_for_nat_gateway" {
  vpc = true
  tags = {
    Name = "eip-for-nat-gateway"
  }
}

# Creating Nat gateway
resource "aws_nat_gateway" "Prod_Nat_gateway" {
  allocation_id = aws_eip.eip_for_nat_gateway.id
  subnet_id     = aws_subnet.prod_Pub_Sub1.id

  tags = {
    Name = "Prod-Nat-gateway"
  }

}
 