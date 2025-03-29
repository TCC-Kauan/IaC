resource "aws_sqs_queue" "this" {
  name = "${var.lambda_function_name}_dlq"
}

resource "aws_security_group" "this" {
  name   = "${var.lambda_function_name}_security_group"
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

data "aws_iam_policy_document" "this" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

  }
}

resource "aws_iam_role" "this" {
  name               = var.lambda_function_name
  assume_role_policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "this_vpc" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

data "aws_iam_policy_document" "this_sqs" {
  statement {
    actions = [
      "sqs:SendMessage"
    ]
    resources = [aws_sqs_queue.this.arn]
  }
}

resource "aws_iam_policy" "this" {
  name        = "sqs${var.lambda_function_name}"
  description = "Write on SQS"
  policy      = data.aws_iam_policy_document.this_sqs.json
}

resource "aws_iam_role_policy_attachment" "this_sqs" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
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
      values = ["/my-application*"]
    }
  }
}

resource "aws_lambda_function" "this" {
  filename      = "${path.module}/settings/sample-package.zip"
  function_name = var.lambda_function_name
  role          = aws_iam_role.this.arn
  handler       = var.lambda_function_handler
  runtime       = var.lambda_function_runtime
  memory_size   = var.lambda_function_memory_size
  timeout       = var.lambda_function_timeout
  architectures = var.lambda_function_architectures
  layers        = var.lambda_function_layers

  vpc_config {
    subnet_ids         = var.subnets_ids
    security_group_ids = [aws_security_group.this.id]
  }

  environment {
    variables = var.lambda_function_variables
  }

  dead_letter_config {
    target_arn = aws_sqs_queue.this.arn
  }
}
