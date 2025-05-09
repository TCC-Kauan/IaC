data "aws_iam_policy_document" "this" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "this" {
  name               = var.service_name
  assume_role_policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_task_definition" "this" {
  family                   = var.task_definition_family
  task_role_arn            = aws_iam_role.this.arn
  execution_role_arn       = aws_iam_role.this.arn
  network_mode             = var.task_definition_network_mode
  cpu                      = var.task_definition_cpu
  memory                   = var.task_definition_memory
  requires_compatibilities = var.task_definition_requires_compatibilities
  container_definitions    = var.task_definition_container_definitions
}

resource "aws_security_group" "this" {
  name   = "${var.task_definition_family}_security_group"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_lb_target_group" "this" {
  name     = var.target_group_name
  port     = var.target_group_port
  protocol = var.target_group_protocol
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    interval            = 30
    path                = var.health_check_path
    port                = var.health_check_port
    protocol            = var.health_check_protocol
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Error"
      status_code  = "404"
    }
  }
}

resource "aws_lb_listener_rule" "this" {
  listener_arn = aws_lb_listener.http_listener.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }

  condition {
    path_pattern {
      values = ["/${var.service_name}*"]
    }
  }
}

resource "aws_ecs_cluster" "this" {
  name = var.cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_service" "this" {
  name                              = var.service_name
  cluster                           = aws_ecs_cluster.this.name
  task_definition                   = aws_ecs_task_definition.this.arn
  desired_count                     = var.service_desired_count
  launch_type                       = var.service_launch_type
  health_check_grace_period_seconds = var.service_health_check_grace_period_seconds

  network_configuration {
    subnets         = var.subnet_ids
    security_groups = [aws_security_group.this.id]
  }

  load_balancer {
    target_group_arn = var.load_balancer_target_group_arn
    container_name   = var.load_balancer_container_name
    container_port   = var.load_balancer_container_port
  }

}

resource "aws_cloudwatch_log_group" "this" {
  name = "/ecs/${var.service_name}"
}
