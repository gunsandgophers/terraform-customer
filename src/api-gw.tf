resource "aws_api_gateway_rest_api" "CustomerAPI" {
  name        = "CustomerAPI"
  description = "API for my Customer Lambda function"
}

resource "aws_api_gateway_resource" "CustomerResource" {
  rest_api_id = aws_api_gateway_rest_api.CustomerAPI.id
  parent_id   = aws_api_gateway_rest_api.CustomerAPI.root_resource_id
  path_part   = "customer"
}

resource "aws_api_gateway_method" "GetCustomerMethod" {
  rest_api_id   = aws_api_gateway_rest_api.CustomerAPI.id
  resource_id   = aws_api_gateway_resource.CustomerResource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "CreateCustomerMethod" {
  rest_api_id   = aws_api_gateway_rest_api.CustomerAPI.id
  resource_id   = aws_api_gateway_resource.CustomerResource.id
  http_method   = "POST"
  authorization = "NONE"
}

# Integrar a Lambda ao API Gateway
resource "aws_api_gateway_integration" "GetCustomerMethodIntegration" {
  rest_api_id             = aws_api_gateway_rest_api.CustomerAPI.id
  resource_id             = aws_api_gateway_resource.CustomerResource.id
  http_method             = aws_api_gateway_method.GetCustomerMethod.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.GetCustomerLambda.invoke_arn
}

resource "aws_api_gateway_integration" "CreateCustomerMethodIntegration" {
  rest_api_id             = aws_api_gateway_rest_api.CustomerAPI.id
  resource_id             = aws_api_gateway_resource.CustomerResource.id
  http_method             = aws_api_gateway_method.CreateCustomerMethod.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.CreateCustomerLambda.invoke_arn
}

# Permitir que o API Gateway invoque a função Lambda
resource "aws_lambda_permission" "allow_api_gateway_GetCustomer" {
  # statement_id  = "AllowAPIGatewayInvokeGetCustomer"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.GetCustomerLambda.function_name
  principal     = "apigateway.amazonaws.com"

  # Define o ARN do API Gateway
  # source_arn = "${aws_api_gateway_rest_api.CustomerAPI.execution_arn}/GetCustomer/*/*"
}

resource "aws_lambda_permission" "allow_api_gateway_CreateCustomer" {
  # statement_id  = "AllowAPIGatewayInvokeCreateCustomer"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.CreateCustomerLambda.function_name
  principal     = "apigateway.amazonaws.com"

  # Define o ARN do API Gateway
  # source_arn = "${aws_api_gateway_rest_api.CustomerAPI.execution_arn}/CreateCustomer/*/*"
}

# Criação do deployment do API Gateway
resource "aws_api_gateway_deployment" "CustomerAPIDeployment" {
  rest_api_id = aws_api_gateway_rest_api.CustomerAPI.id
  stage_name  = "dev"

  depends_on = [
    aws_api_gateway_integration.GetCustomerMethodIntegration,
    aws_api_gateway_integration.CreateCustomerMethodIntegration,
  ]
}

output "api_url" {
  value = "${aws_api_gateway_rest_api.CustomerAPI.execution_arn}/customer"
}
