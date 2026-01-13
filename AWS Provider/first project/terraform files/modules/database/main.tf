resource "aws_db_subnet_group" "this" {
  name       = var.backend_subnet_name
  subnet_ids = var.backend_subnet_ids
}

resource "aws_db_instance" "this" {
  identifier              = "web-app-db"
  engine                  = "mysql"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.this.name
  skip_final_snapshot     = true
  publicly_accessible     = false

}