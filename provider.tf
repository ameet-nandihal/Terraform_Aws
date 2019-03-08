provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.region}"
}


resource "aws_instance" "example" {
  count         = "${aws_subnet.subnets.count}"
  instance_type = "t2.micro"
  ami           = "${lookup(var.amis, var.region)}"
  key_name      = "${aws_key_pair.mykey.key_name}"
  subnet_id     = "${element(data.aws_subnet_ids.private.ids, count.index)}"
  vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}"]

  tags {
    name = "ec2_instance-${count.index+1}"
  }
  depends_on = ["aws_subnet.subnets"]
}

resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = "${file(var.PATH_TO_PUBLIC_KEY)}"
}
