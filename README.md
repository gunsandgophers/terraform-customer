# Terraform Customer

## Descrição do Projeto

O projeto **Terraform-Customer** é responsável pela infraestrutura relacionada aos clientes do techchallenge. Ele provisiona os recursos necessários na AWS, incluindo um User Pool do Amazon Cognito, duas funções Lambda (uma para getCustomer e outra para createCustomer), e um API Gateway que conecta as rotas às respectivas funções Lambda.


## Exemplos de Consumo da API
### 1. Criar Cliente

**Endpoint**: POST /customer
https://1gy1nnl5c1.execute-api.us-east-1.amazonaws.com/dev/customer

json body
```json
{"name": "José das Couves", "email": "jose@email.com", "cpf": "07878469024"}
```


### 2. Obter Cliente

Endpoint: GET /customer?cpf={customerCPF}
https://1gy1nnl5c1.execute-api.us-east-1.amazonaws.com/dev/customer?cpf=07878469024