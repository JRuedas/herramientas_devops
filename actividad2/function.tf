# Create the lambda function from the source code specified in the variables. Creates the IAM policy and role for the Lambda function. 
# Attatches the policy and roles to the function. Creates the Archive.
module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = var.function_name
  description   = var.function_description
  handler       = var.function_handler
  source_path   = var.function_source_path
  runtime       = "python3.8"

  tags = var.tags
}