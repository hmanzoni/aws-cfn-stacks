# WordPress Nested Stack AWS :rocket:

## Project description

This is a project create for deploy a WordPress website using AWS CloudFormation.
The WordPress site FrontEnd is deployed into EC2, the Database is located in RDS services (Multi-AZ), the File System use EFS services mounted in differents AZ and the endpoint is handle by Application Load Balancer. All the instances provisioning is handle by the Auto Scaling Group which control in base at the quantity of request into the EC2 instance.


## Deploy of WordPress in AWS

1. Enter in your AWS account.
2. Go to the service AWS `Systems Manager` and then to `Parameter Store` (on the left).
3. Create a new parameter which will be used for setup the Database password:
```text
Name: "/App/WP/DBPassword"
Tier: Standard
Type: SecureString
KMS Key Source: My Current Account
KMS Key ID as default 
Value: (write your secure password)
Click Create parameter
```
4. Now for deploy all the structure you should go to `CloudFormation` then `Stacks` and `Create stack` > `with new resources (standard)`.
5. Into the input "Amazon S3 URL" you should enter this URL https://cnwp-nested-stack-202211.s3.amazonaws.com/wp/WPNestedStack.json the press `Next`.
6. You must provide a name for you stack and you can modify some options for configurate the Database, Instance EC2 and version of Wordpress. Please press `Next`.
7. Now press `Next` again, and in Capabilities check the acknowledge checkboxes and then `Submit`.
8. Now you need wait all the stacks be complete.
9. You can enter on the website using the URL which can found in `Systems Manager` > `Parameter Store` > `/App/WP/ALBDNSNAME` > `Value`


## AWS Architecture Worpress

The architecture of the App is compose by: 
1. `VPC` /20 with 9 `subnets` /16 where 3 are public and 6 are private, leaving 7 subnets /16 for spare and future uses.
2. The stack will provide also the necessary `Security Group`, `Route Table` with their associations and `Internet Gateway`
3. `Relational Database Service` using MySQL as Database engine with Multi AZ deployed in 3 private subnets around 3 Availability Zone.
4. `Elastic File System` (EFS) mounted in 3 different Availability Zone as folder wp-content for save.
5. `Application Load Balancer` (ALB) for distribute the connection in all the available EC2 instances (Front end website) around the 3 public subnets in different AZ.
6. `Launch Template` which contain all the characteristic for create the instances and even for deploy a Wordpress website, mounting the EFS (step 4), seting up the credentials for connect to Database (step 3) and adding the DNS Name of the Load Balancer (step 5) as URL for the website.
7. `Auto Scaling Group` (ASG) which have a health check on the instance EC2, so if a instance stopped or is unhealthy the ASG will be provide a new instance using the `Launch Template`. The ASG have also a `Auto Scaling Policy` based on `Target Tracking Scaling` of the number of request on the instance, in case the number (which can set at the beginning before launch the stack) is exceed the ASG will be provide new intances.
8. The ASG keep as Desired Capacity 6 EC2 Instance with a minimum of 3 running and provide until 9 EC2 as maximum.


## AWS Architecture diagrams

![App Architecture](https://github.com/hcaman/aws-cfn-stacks/blob/master/nested/wp/Arch_diagram.png?raw=true)
