/**

**/

variable "vpc_id" {}
variable "subnet_ids" {}
variable "allowed_cidr_blocks" {}

module "lambda_stage_1" {
  source = "../../../modules/services/lambda"

  lambda_function_name          = "lambda_stage_1"
  lambda_function_handler       = "lambda_function.lambda_handler"
  lambda_function_runtime       = "python3.11"
  lambda_function_architectures = ["x86_64"]
  lambda_function_memory_size   = 190
  lambda_function_timeout       = 500

  lambda_function_variables = {
    "POWERTOOLS_SERVICE_NAME" : "lambda_stage_1"
  }
  lambda_function_layers = [
    "arn:aws:lambda:us-east-1:017000801446:layer:AWSLambdaPowertoolsPythonV2:29"
  ]

  vpc_id              = var.vpc_id
  subnets_ids         = var.subnet_ids
  allowed_cidr_blocks = var.allowed_cidr_blocks

}
