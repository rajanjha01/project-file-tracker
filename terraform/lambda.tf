## Lambda function for s3 trigger

resource "aws_lambda_function" "filetracker" {
  function_name = var.function_name
  description   = "Store the s3 object filename name into dynamoDB table"
  role          = aws_iam_role.filetracker-iam-role.arn
  runtime       = var.nodejsver
  handler       = "index.handler"
  architectures = ["x86_64"]
  filename      = "src/lambda/lambda_function/index.zip"

  environment {
    variables = {
      DBTable    = var.dynamodb_table_name
    }
  }
}

######################################