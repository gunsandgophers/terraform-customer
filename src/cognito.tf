resource "aws_cognito_user_pool" "cognito" {
  name = var.CustomersPoolName

  schema {
    name                     = "name"
    attribute_data_type      = "String"
    mutable                  = true
    required                 = true
    developer_only_attribute = false
  }
}
