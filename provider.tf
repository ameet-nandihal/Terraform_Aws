provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.region}"
}

resource "aws_vpc" "myfirst_vpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"

  tags = {
    Name     = "myfirst_vpc"
    Location = "Bangalore"
  }
}

resource "aws_subnet" "subnets" {
  count             = "${length(data.aws_availability_zones.azs.names)}"
  availability_zone = "${element(data.aws_availability_zones.azs.names, count.index)}"
  vpc_id            = "${aws_vpc.myfirst_vpc.id}"
  cidr_block        = "${element(var.subnet_cidr, count.index)}"

  tags = {
    Name = "subnet-${count.index+1}"
  }
}

data "aws_subnet_ids" "private" {
  vpc_id = "${aws_vpc.myfirst_vpc.id}"
}

resource "aws_instance" "example" {
  count         = "${aws_subnet.subnets.count}"
  instance_type = "t2.micro"
  ami           = "${lookup(var.amis, var.region)}"
  key_name      = "${aws_key_pair.mykey.key_name}"
  subnet_id     = "${element(data.aws_subnet_ids.private.ids, count.index)}"

  tags {
    name = "ec2_instance-${count.index+1}"
  }
  depends_on = ["aws_subnet.subnets"]

}

resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = "${file(var.PATH_TO_PUBLIC_KEY)}"
}
