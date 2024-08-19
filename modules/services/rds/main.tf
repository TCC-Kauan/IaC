
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

resource "aws_rds_cluster" "this" {
  cluster_identifier               = var.cluster_identifier
  engine                           = var.engine
  engine_version                   = var.engine_version
  storage_encrypted                = true
  availability_zones               = var.availability_zones
  database_name                    = "techsolutions"
  deletion_protection              = true
  master_username                  = "dbadmin"
  master_password                  = random_password.this.result
  db_cluster_parameter_group_name  = ""
  db_instance_parameter_group_name = ""
  vpc_security_group_ids           = [""]
  preferred_maintenance_window     = var.preferred_maintenance_window
  backup_retention_period          = 7
  backtrack_window                 = 0
  copy_tags_to_snapshot            = true
  skip_final_snapshot              = false
  final_snapshot_identifier        = "${var.cluster_identifier}_final_snapshot"
  enabled_cloudwatch_logs_exports  = var.enabled_cloudwatch_logs_exports
  tags                             = var.tags

  lifecycle {
    ignore_changes = [availability_zones]
  }
}

resource "aws_rds_cluster_instance" "this" {
  count                                 = var.slave_count > 0 ? (var.slave_count + 1) : 1
  identifier                            = format("%s_%s", var.cluster_identifier, count.index == 0 ? "master" : "slave_${count.index}")
  cluster_identifier                    = var.cluster_identifier
  instance_class                        = var.instance_class
  engine                                = var.engine
  engine_version                        = var.engine_version
  db_parameter_group_name               = var.db_parameter_group_name
  db_subnet_group_name                  = var.db_subnet_group_name
  publicly_accessible                   = false
  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  preferred_maintenance_window          = var.preferred_maintenance_window
  monitoring_interval                   = strcontains(var.environment, "prod") ? 60 : 0
  monitoring_role_arn                   = strcontains(var.environment, "prod") ? var.monitoring_role_arn : ""
  tags                                  = var.tags
}