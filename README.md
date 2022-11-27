# FileTracker
# Solution Architecture & High-Level Design

--------------------------------------------------------------------------------------------
|Solution Name:     | FileTracker – track a list of files that have been uploaded to S3     | 
|-------------------|-----------------------------------------------------------------------|
|Author             | Rajan Jha                                                             |
---------------------------------------------------------------------------------------------

# Table of Contents 

1.	Solution Summary
2.	Requirements
3.	Application architecture
4.	Folder structure
5.	Deployment
   *	Prerequisite
   *	TF setup

# 1.Solution Summary

FileTracker is a serverless Lambda based application which is used to track a list of files that have been uploaded to s3 in the backend database.
FileTracker is hosted on AWS and consumes below AWS resources – 

*	Lambda Function
*	DynamoDB
*	S3
*	IAM

# 2. Requirements

|             Requirements	                                |                          Solution                                 |
------------------------------------------------------------|--------------------------------------------------------------------
|A S3 Bucket to where we upload files                       | Creating a BucketName fileTracker to upload all the files         | 
|Database as backend to svae the uploaded filename          | DynamoDb table called `Files` with an attribute `FileName`        |
|Stepfunction that writes to the DynamoDb table             | A js based Lambda function gets triggered after every s3 upload   |

# 3. Application architecture
<img width="684" alt="image" src="https://user-images.githubusercontent.com/82893856/204120036-0556d4ee-934f-4d25-9068-73d04b3e5f61.png">

# 4. Folder structure

```
.
|
terraform
├── src                        # Lambda source code
|   ├── src/lambda_handlers    # Lambda source code with dependencies
...
(terraform files)             # Terraform config to deploy IAM role, Lambda function, s3 and DynamoDB backend db. 
...             
└── README.md

```

# 5. Deployment

* # Prerequisite 

    1. Configure AWS localstack on your local system.
    2. Terraform (> v1.0.11 or higher). 




