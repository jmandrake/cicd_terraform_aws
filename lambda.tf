
resource "null_resource" "create_zip" {
  triggers = {
    always_run = "${timestamp()}"  # Ensure the provisioner always runs
  }

  provisioner "local-exec" {
    command = <<-EOT
      mkdir -p ${path.module}/zip
      cd ${path.module}/api
      zip -r ../zip/api.zip .
    EOT
  }
}




resource "aws_s3_object" "lambda" {
  bucket = var.aws_s3_bucket
  key    = "api.zip"
  source = "${path.module}/zip/api.zip"
  etag   = filemd5("${path.module}/zip/api.zip")
}

resource "aws_lambda_function" "lambda" {
  for_each         = local.routes
  function_name    = "${var.lambda_function_name_prefix}-${each.value.name}"
  s3_bucket        = "api-lambda-dynamodb-demo"
  s3_key           = "api.zip"
  runtime          = "python3.9"  # Change the runtime to Python 3.9
  handler          = "${each.value.name}.lambda_handler"  # Use specific handler for each lambda
  role             = aws_iam_role.lambda[each.value.name].arn
  architectures    = ["arm64"]

  environment {
    variables = {
      jwtSecret = var.jwtSecret
    }
  }
}


resource "aws_lambda_permission" "lambda" {
  for_each      = local.routes
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda[each.value.name].function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.api.execution_arn}/*/*"
}

resource "aws_cloudwatch_log_group" "cloudwatch" {
  for_each          = local.routes
  name              = "/aws/lambda/${aws_lambda_function.lambda[each.value.name].function_name}"
  retention_in_days = 1
}
