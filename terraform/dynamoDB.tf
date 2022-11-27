##############################################################################
## Define tagging 
locals {
  tags = {
    Terraform   = "true"
    Environment = "Prod"
  }
}
###############################################################################
# DynamoDB Table to store filenames which are uploaded on s3 bucket
###############################################################################

resource "aws_dynamodb_table" "filetracker-dynamo" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "FileName"

  server_side_encryption {
    enabled = true
  }

  attribute {
    name = "FileName"
    type = "S"
  }
  tags = local.tags
}
##########################