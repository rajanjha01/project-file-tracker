## A private s3 bucket to store files

resource "aws_s3_bucket" "filetracker-s3" {
  bucket = var.bucket_name
  acl    = "private"
  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = local.tags
}
resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.filetracker-s3.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

##S3 Bucket permission to trigger the lambda function

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.filetracker.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.filetracker-s3.arn
}
 
## s3 trigger for object creation

resource "aws_s3_bucket_notification" "upload" {
  bucket = aws_s3_bucket.filetracker-s3.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.filetracker.arn
    events              = ["s3:ObjectCreated:*"]
  }
  depends_on = [aws_lambda_permission.allow_bucket]
}

########################################################
########################################################