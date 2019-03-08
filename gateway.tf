resource "aws_internet_gateway" "main-gw" {
  vpc_id = "${aws_vpc.myfirst_vpc.id}"
}


resource "aws_route_table" "main" {
  vpc_id = "${aws_vpc.myfirst_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main-gw.id}"
  }
}

resource "aws_route_table_association" "main-public" {
  count         = "${aws_subnet.subnets.count}"
  subnet_id      = "${element(data.aws_subnet_ids.private.ids, count.index)}"
  route_table_id = "${aws_route_table.main.id}"
}

resource "aws_security_group" "allow-ssh" {
  vpc_id = "${aws_vpc.myfirst_vpc.id}"
   ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
