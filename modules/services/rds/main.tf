
resource "random_password" "this" {
  length           = 16
  special          = true
  override_special = "#!$"
}

resource "aws_secretsmanager_secret" "this" {
  name = "${var.cluster_identifier}_secret"
  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = random_password.this.result
}

resource "aws_db_instance" "this" {
  allocated_storage = var.db_
}
