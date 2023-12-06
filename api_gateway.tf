resource "aws_api_gateway_rest_api" "notes_api" {
  name = "NotesAPI"
}

resource "aws_api_gateway_resource" "api_resource" {
  rest_api_id = aws_api_gateway_rest_api.notes_api.id
  parent_id   = aws_api_gateway_rest_api.notes_api.root_resource_id
  path_part   = "notes"
}

# New resource for handling '/notes/{noteId}'
resource "aws_api_gateway_resource" "api_resource_noteId" {
  rest_api_id = aws_api_gateway_rest_api.notes_api.id
  parent_id   = aws_api_gateway_resource.api_resource.id
  path_part   = "{noteId}"
}

resource "aws_api_gateway_method" "api_method_put" {
  rest_api_id   = aws_api_gateway_rest_api.notes_api.id
  resource_id   = aws_api_gateway_resource.api_resource.id
  http_method   = "PUT"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "api_integration_put" {
  rest_api_id   = aws_api_gateway_rest_api.notes_api.id
  resource_id   = aws_api_gateway_resource.api_resource.id
  http_method   = aws_api_gateway_method.api_method_put.http_method
  type          = "AWS_PROXY"
  integration_http_method = "POST"
  uri           = aws_lambda_function.notes_lambda_function.invoke_arn
}

resource "aws_api_gateway_method" "api_method_get" {
  rest_api_id   = aws_api_gateway_rest_api.notes_api.id
  resource_id   = aws_api_gateway_resource.api_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "api_integration_get" {
  rest_api_id   = aws_api_gateway_rest_api.notes_api.id
  resource_id   = aws_api_gateway_resource.api_resource.id
  http_method   = aws_api_gateway_method.api_method_get.http_method
  type          = "AWS_PROXY"
  integration_http_method = "POST"
  uri           = aws_lambda_function.notes_lambda_function.invoke_arn
}

# New method and integration for GET request on '/notes/{noteId}'
resource "aws_api_gateway_method" "api_method_get_noteId" {
  rest_api_id   = aws_api_gateway_rest_api.notes_api.id
  resource_id   = aws_api_gateway_resource.api_resource_noteId.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "api_integration_get_noteId" {
  rest_api_id   = aws_api_gateway_rest_api.notes_api.id
  resource_id   = aws_api_gateway_resource.api_resource_noteId.id
  http_method   = aws_api_gateway_method.api_method_get_noteId.http_method
  type          = "AWS_PROXY"
  integration_http_method = "POST"
  uri           = aws_lambda_function.notes_lambda_function.invoke_arn
}

resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [
    aws_api_gateway_integration.api_integration_put,
    aws_api_gateway_integration.api_integration_get,
    aws_api_gateway_integration.api_integration_get_noteId
  ]

  rest_api_id = aws_api_gateway_rest_api.notes_api.id
  stage_name  = "dev"
}
