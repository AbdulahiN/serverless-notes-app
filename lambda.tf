resource "aws_lambda_function" "notes_lambda_function" {
  function_name    = "NotesFunction"
  role             = aws_iam_role.lambda_role.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.8"
  filename         = "/Users/abdulahi/Desktop/project/serverless/lambda_function.zip"
  source_code_hash = filebase64sha256("/Users/abdulahi/Desktop/project/serverless/lambda_function.zip")

  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.notes_table.name
    }
  }
}

resource "aws_lambda_permission" "api_gateway_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.notes_lambda_function.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.notes_api.execution_arn}/*/notes*"
}
