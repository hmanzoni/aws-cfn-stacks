# API Gateway Serverless App AWS :rocket:

## Project description

This is a project create for deploy a API Gateway and State Machine using AWS CloudFormation.
The API Gateway is connected with a Lambda function which can send a order to a State Machine, the State Machine will handle the state for send a Email (using SES), SMS (using SNS) or Both. All the API can be handle by the website uploaded to a Bucket S3 configured as Static Website.


## Deploy Serverless App

### Create the Stack and deploy the resources
1. Now for deploy all the structure you should go to `CloudFormation` then `Stacks` and `Create stack` > `with new resources (standard)`.
2. Into the input "Amazon S3 URL" you should enter this URL https://hugo-manzoni-labs.s3.amazonaws.com/stacks/apiserveless/APINestedStack.yaml the press `Next`.
3. You must provide a name for you stack and add a valid email. Please press `Next`.
4. Now press `Next` again, and in Capabilities check the acknowledge checkboxes and then `Submit`.
5. You will receive an email from AWS with the subject "Amazon Web Services – Email Address Verification Request in region..." in order to verify the email address setup in point 3. 
6. Now you need wait all the stacks be complete.
7. At this point you can use the API URL on the FrontEnd App using the URL which you can find in `Systems Manager` > `Parameter Store` > `/Serveless/APIGateway/URL` > `Value`

### Configuration SMS Service
1. Enter in your AWS account.
2. Go to the service AWS `Simple Notification Service` and then to `Text Messaging (SMS)` under `Mobile` (on the left).
3. Scroll down and in `Sandbox destination phone numbers` click `Add phone number`, enter the international number format of a phone number you control.
4. Pick the `verification message language` you want to use. Click `Add phone Number`.


## AWS Architecture Worpress
The architecture of the App is compose by: 
1. The service `Simple Notification Service` (SNS) and `Simple Email Service` (SES) used to delivery the message from the user (FrontEnd) to the client by SMS or Email.
2. `API Gateway` as REST API with the configuration CORS allowing the communication with the website.
3. The `State Machine` with the steps function in order to handle the state get from the API Service and trigger the service of messages. ![State Machine Steps](https://github.com/hcaman/aws-cfn-stacks/blob/master/nested/api/stuff/stepfunctions_graph.png?raw=true)
4. `Lambda Function` used for check and communicate the action from the API to the State Machine.
5. `Lambda Function` which receive the information from the State Machine and send the all the information for send the Email using SES.
6. `SSM Parameter` where will it be saved the URL of the API created with the stack.

## AWS Architecture diagrams

![App Architecture](https://github.com/hcaman/aws-cfn-stacks/blob/master/nested/api/Arch_diagram.png?raw=true)

## Credits
This entire idea is based on this project: https://github.com/acantril/learn-cantrill-io-labs/tree/master/aws-serverless-pet-cuddle-o-tron. I just convert the idea in CloudFormation as a practice.
A special thanks goes to Adrian Cantril :smiley:.