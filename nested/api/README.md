# API Gateway Serverless App AWS :rocket:

## Project description

This project was created to deploy an API Gateway and State Machine using AWS CloudFormation. The API Gateway is connected to a Lambda function, which can send an order to a State Machine. The State Machine will handle the state to send an email (using SES), SMS (using SNS), or both. All APIs can be handled by the website uploaded to an S3 bucket configured as a static website.

## Deploy Serverless App

### Create the Stack and deploy the resources

1. Now for deploy all the structure you should go to `CloudFormation` then `Stacks` and `Create stack` > `with new resources (standard)`.
1. Into the input "Amazon S3 URL" you should enter this URL https://hugo-manzoni-labs.s3.amazonaws.com/stacks/apiserveless/APINestedStack.yaml the press `Next`.
1. You must provide a name for you stack and add a valid email. Please press `Next`.
1. Now press `Next` again, and in Capabilities check the acknowledge checkboxes and then `Submit`.
1. You will receive an email from AWS with the subject "Amazon Web Services – Email Address Verification Request in region..." in order to verify the email address setup in point 3.
1. Now you need wait all the stacks be complete.
1. At this point you can use the API URL on the FrontEnd App using the URL which you can find in `Systems Manager` > `Parameter Store` > `/Serveless/APIGateway/URL` > `Value`

### Configuration SMS Service

1. Enter in your AWS account.
1. Go to the service AWS `Simple Notification Service` and then to `Text Messaging (SMS)` under `Mobile` (on the left).
1. Scroll down and in `Sandbox destination phone numbers` click `Add phone number`, enter the international number format of a phone number you control.
1. Pick the `verification message language` you want to use. Click `Add phone Number`.

## AWS Architecture Worpress

The architecture of the App is compose by:

1. The service `Simple Notification Service` (SNS) and `Simple Email Service` (SES) used to delivery the message from the user (FrontEnd) to the client by SMS or Email.
1. `API Gateway` as REST API with the configuration CORS allowing the communication with the website.
1. The `State Machine` with the steps function in order to handle the state get from the API Service and trigger the service of message1. ![State Machine Steps](https://github.com/hcaman/aws-cfn-stacks/blob/master/nested/api/stuff/stepfunctions_graph.png?raw=true)
1. `Lambda Function` used for check and communicate the action from the API to the State Machine.
1. `Lambda Function` which receive the information from the State Machine and send the all the information for send the Email using SES.
1. `SSM Parameter` where will it be saved the URL of the API created with the stack.

## AWS Architecture diagrams

![App Architecture](https://github.com/hcaman/aws-cfn-stacks/blob/master/nested/api/Arch_diagram.png?raw=true)

## Credits

This idea is entirely based on the project located at https://github.com/acantril/learn-cantrill-io-labs/tree/master/aws-serverless-pet-cuddle-o-tron. As a means of practice, I converted the idea into a CloudFormation template.
A special thanks goes to Adrian Cantril :smiley:.
