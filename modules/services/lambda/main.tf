resource "aws_sqs_queue" "this" {
  name = "${var.lambda_function_name}_dlq"
}

resource "aws_security_group" "this" {
  name   = "${var.lambda_function_name}_security_group"
  vpc_id = var.vpc_id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
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
    subnet_ids         = var.lambda_function_subnets_ids
    security_group_ids = [aws_security_group.this.id]
  }

  environment {
    variables = var.lambda_function_variables
  }

  dead_letter_config {
    target_arn = aws_sqs_queue.this.arn
  }

  tags = var.tags

}
