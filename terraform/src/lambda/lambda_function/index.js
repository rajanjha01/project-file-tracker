// Load the AWS SDK for Node.js
var AWS = require('aws-sdk');

// Import dynamodb from aws-sdk
const dynamodb = require('aws-sdk/clients/dynamodb');

// AWS Config for localstack

AWS.config.update({
    region: "eu-central-1",
    endpoint: 'http://localhost:4566',
    accessKeyId: "foobar",
    secretAccessKey: "foobar"
  });
// Get the DynamoDB table name from environment variables
const tableName = process.env.DBTable;

// Initialise a dynamodb client
//const docClient = new dynamodb.DocumentClient();
const docClient = new dynamodb.DocumentClient({
    endpoint: 'http://localhost:4566',
  });

exports.handler = (event, context, callback) => {
var s3Key = event.Records[0].s3.object.key;
    
console.log(event);
console.log('received:', JSON.stringify(event));
    
// Create the DynamoDB service object
var ddb = new AWS.DynamoDB({apiVersion: '2012-08-10'});
    
var params = {
        TableName: 'tableName',
        Item: {
            'FileName': {S: s3Key},
        },
    };
    
    // Adding the items inot the DynamoDB table
ddb.putItem(params, function(err,data){

    if(err){
        console.log("Error: ", err);
    }
        else
        {
        console.log("Item entered successfully:", data);
        }
    });
    
};