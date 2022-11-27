## Print the s3 bucket and dynamo table name

output "filetracker_dynamo_db" {
  value       = aws_dynamodb_table.filetracker-dynamo.id
  description = "Name of the Dynamo db table where object filename will be saved"
}

output "filetracker_s3_bucket" {
  value       = aws_s3_bucket.filetracker-s3.id
  description = "S3 Bucket to save the files"
}