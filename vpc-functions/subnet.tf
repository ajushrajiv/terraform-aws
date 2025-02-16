# Liste der AZs, Subnet-CIDRs und Namen der Subnetze
locals {
  azs                  = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  public_subnets       = ["10.0.1.0/24", "10.0.3.0/24", "10.0.5.0/24"]
  private_subnets      = ["10.0.2.0/24", "10.0.4.0/24", "10.0.6.0/24"]
  public_subnet_names  = ["public-subnet-1a", "public-subnet-1b", "public-subnet-1c"]
  private_subnet_names = ["private-subnet-1a", "private-subnet-1b", "private-subnet-1c"]
}

# Erstelle öffentliche Subnetze
resource "aws_subnet" "public" {
  count = length(local.azs) # 3 ,Index:  Je nach Iteration: 0, 1, 2 

  vpc_id                  = aws_vpc.main.id
  cidr_block              = local.public_subnets[count.index]
  availability_zone       = local.azs[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = local.public_subnet_names[count.index]
  }
}

# Erstelle private Subnetze
resource "aws_subnet" "private" {
  count = length(local.azs)

  vpc_id            = aws_vpc.main.id
  cidr_block        = local.private_subnets[count.index]
  availability_zone = local.azs[count.index]
  tags = {
    Name = local.private_subnet_names[count.index]
  }
}

# Erstelle eine öffentliche Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Verbinde öffentliche Subnetze mit der öffentlichen Route Table
resource "aws_route_table_association" "public_rta" {
  count          = length(local.azs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

# Erstelle eine private Route Table (optional für NAT)
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "private-route-table"
  }
}

# Verbinde private Subnetze mit der privaten Route Table
resource "aws_route_table_association" "private_rta" {
  count          = length(local.azs)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private_rt.id
}
