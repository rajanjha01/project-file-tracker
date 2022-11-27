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

 * # Terraform Setup

    # Local backend 

    This project has been setup with local backend. 

    # Application deployment

    * We are deploying the s3 bucket, iam role, lambda function and dynamodb in eu-central-1 region.
      Lambda zip has the lib dependencies in node_modules. 

    Steps to deploy - 
      * Clone the repo on your local system and ```cd project-file-tracker/terraform```
      * setup backend.tf with local.
      * setup localstack as aws providers. 
      * Create variables in ```variables.tf``` and put all the values in ```terraform.tfvars```
      * Run ```terraform init``` ```terraform plan``` and ```terraform apply```. 
      * Open another terminal.

      Configure AWS  - 

      ## Authentication
		```
		export AWS_ACCESS_KEY_ID=foobar
		export AWS_SECRET_ACCESS_KEY=foobar
		export AWS_REGION=eu-central-1
    	```

       ## Upload file to s3 bucket

        ```
		aws --endpoint-url http://localhost:4566 s3 cp README.md s3://test-bucket/
		```
            	<img width="689" alt="image" src="https://user-images.githubusercontent.com/82893856/204120778-78b4fd38-bea4-49b9-95c6-f426c1e8c83b.png">
		

	   ## This should create an entry in the backend database

		```
		aws --endpoint-url http://localhost:4566 dynamodb scan --table-name Files
		```
		🤺 🍺🍺 $aws --endpoint-url http://localhost:4566 dynamodb scan --table-name Files
 		<img width="713" alt="image" src="https://user-images.githubusercontent.com/82893856/204120790-8dc161d7-bb0d-43de-825e-d513df90ba6e.png">

                <img width="785" alt="image" src="https://user-images.githubusercontent.com/82893856/204120801-25733557-0549-46ff-b417-a64310ab3cbd.png">

      




