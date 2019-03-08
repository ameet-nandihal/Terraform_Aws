resource "aws_subnet" "subnets" {
  count                   = "${length(data.aws_availability_zones.azs.names)}"
  availability_zone       = "${element(data.aws_availability_zones.azs.names, count.index)}"
  vpc_id                  = "${aws_vpc.myfirst_vpc.id}"
  cidr_block              = "${element(var.subnet_cidr, count.index)}"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "subnet-${count.index+1}"
  }

  depends_on = ["aws_vpc.myfirst_vpc"]
}

data "aws_subnet_ids" "private" {
  vpc_id     = "${aws_vpc.myfirst_vpc.id}"
  depends_on = ["aws_subnet.subnets"]
}
