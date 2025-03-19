module "lambda_stage_1" {
  source = "../../../modules/services/lambda"

  lambda_function_name          = "lambda_prod_1"
  lambda_function_handler       = "lambda_function.lambda_handler"
  lambda_function_runtime       = "python3.11"
  lambda_function_architectures = ["x86_64"]
  lambda_function_subnets_ids   = ["subnet-0636a3abc4fdf221a"]
  lambda_function_memory_size   = 190
  lambda_function_timeout       = 500

  lambda_function_variables = {
    "POWERTOOLS_SERVICE_NAME" : "lambda_prod_1"
  }
  lambda_function_layers = [
    "arn:aws:lambda:us-east-1:017000801446:layer:AWSLambdaPowertoolsPythonV2:29"
  ]

  vpc_id              = "vpc-06a8d4228443ca62c"
  allowed_cidr_blocks = ""

}
