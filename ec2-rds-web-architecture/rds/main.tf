resource "aws_db_instance" "test" {
  allocated_storage    = 20
  db_name              = "terraformtest"
  engine               = "postgres"
  engine_version       = "14"
  instance_class       = "db.t3.micro"
  username             = "foo"
  password             = "barbarbar"
  parameter_group_name = "default.postgres14"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.test-db-subnet.name
}

resource "aws_db_subnet_group" "test-db-subnet" {
  name       = "tf test"
  subnet_ids = [var.db_private_subnet1, var.db_private_subnet2]

  tags = {
    Name = "tf test"
  }
}