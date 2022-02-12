module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = var.function_name
  description   = var.function_description
  handler       = var.function_handler
  source_path   = var.function_source_path
  runtime       = "python3.8"

  tags          = var.tags
}