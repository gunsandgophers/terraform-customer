resource "aws_lambda_function" "CreateCustomerLambda" {
  function_name    = "create_customer"
  role             = aws_iam_role.iam-role.arn
  runtime          = "provided.al2023"
  handler          = "bootstrap"
  filename         = "dummy.zip" # apenas para criar a lambda, o handler sera atualizado pelo gh actions
  source_code_hash = filebase64sha256("dummy.zip")

  environment {
    variables = {
      TC_AWS_REGION : var.regionDefault
      TC_AWS_COGNITO_USER_POOL_ID : aws_cognito_user_pool.cognito.id
    }
  }
}

resource "aws_lambda_function" "GetCustomerLambda" {
  function_name    = "get_customer"
  role             = aws_iam_role.iam-role.arn
  runtime          = "provided.al2023"
  handler          = "bootstrap"
  filename         = "dummy.zip" # apenas para criar a lambda, o handler sera atualizado pelo gh actions
  source_code_hash = filebase64sha256("dummy.zip")

  environment {
    variables = {
      TC_AWS_REGION : var.regionDefault
      TC_AWS_COGNITO_USER_POOL_ID : aws_cognito_user_pool.cognito.id
    }
  }
}
