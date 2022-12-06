# AWS CloudFormation Templates :rocket:

## Overview

The goal of this repository is store my personal CloudFormation templates and provided to the community in order to create single or nested stacks to build real projects.
The provided CloudFormation template automates the entire creation and deployment of AWS Products. 
The project includes the following templates:
1. VPC Structures 
   1. This include: Internet Gateway, Subnets and their Route Tables Associations
2. Lambda Functions
3. AWS IAM Roles
4. Amazon Relational Database Service (**RDS**)
5. Amazon Elastic File System (**EFS**) File System (**FS**)
6. Application Load Balancers (**ALB**)
7. Launch Template
8. AutoScaling Group (**ASG**)

## Prerequisite

- You must have an AWS account.
  - Create an AWS following the official tutorial from AWS -> https://docs.aws.amazon.com/accounts/latest/reference/manage-acct-creating.html  

***IMPORTANT NOTE:** Creating stacks in your AWS account will create and consume AWS resources, which **will cost money**. I do not take any responsibility for the additional cost to use these templates, you should get information about the prices by using the official website. Be sure to shut down/remove all the resources once you have finished to avoid ongoing charges to your AWS account (see instructions on cleaning up/tear down below).*

## How to use

1. Enter in your AWS account.
2. Search the service AWS `CloudFormation` and then click the service.
3. Inside this service you should search the option `Stacks`, click it. 
4. Here you need go to click the dropdown menu `Create stack` > `with new resources (standard)`.
5. Now inside the box `Prerequisite - Prepare template` you can choose how validate and prepare the template. I recommend you use `Create template in Designer`, then into the box below click in `Create template in Designer`.
6. Click in `Template`, select all inside and paste one of the templates.
7. Click in `Create stack` (Cloud icon :cloud:), you should redirect to the before page, then click `Next`.
8. You will be redirect to `Specify stack details`, fill all the inputs then click `Next`.
9. You will be redirect to `Configure stack options`, go down and click `Next`.
10. You will be redirect to `Review test`, go down, sometimes will be require the section of **Capabilities** check the `acknowledge` box, read it and check it.
11. Click `Submit`.
12. Wait until the stack if created, you can refresh the status, must change from `CREATE_IN_PROGRESS` to `CREATE_COMPLETE`.
13. Into the tab **Resources** you can see all the services deployed.

## Cleaning up

To tear down your application and remove all resources associated with the Template, follow these steps:

1. Log into the AWS CloudFormation service. 
2. Go to `Stacks`.
3. Find and select the stack you created.
4. Delete the stack using the button `Delete`.

*Remember to shut down/remove all related resources once you are finished to avoid ongoing charges to your AWS account.*

## License Summary

This sample code is made available under a modified MIT license. See the LICENSE file.






