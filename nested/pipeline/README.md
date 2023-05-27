# CI/CD Pipeline AWS :rocket:

## Project description

This is a project that aims to create a seamless **CI/CD Pipeline** using AWS CloudFormation. The pipeline is intricately linked with a _CodeCommit_ repository, which automatically deploys a new _ECR Image_ each time a code commit is made. This process then initiates a new _ECS service_ and deactivates the previous one, ensuring that the application is always up-to-date, making it available and accessible across the internet.

## Deploy CI/CD Pipeline

### Prerequisites

- Create a Bucket S3 in your AWS Account
- Run your App/Code with Docker

### Before create the Stack

1. Define a file `Dockerfile` with the instructions for run your code.
1. Download the `buildspec.yml` file from this [link buildspec][my-buildspec-file].
1. Put the files `Dockerfile` and `buildspec.yml` in the root folder of your code.
1. Compress your code as zip, you can use the default name is "app".
1. Upload the `app.zip` file into the bucket S3

Note: You can add or create you on buildspec.yml file following the instructions on AWS -> [Build specification reference for CodeBuild][buildspec]

### Create the Stack and deploy the resources

1. Now for deploy all the structure you should go to `CloudFormation` then `Stacks` and `Create stack` > `with new resources (standard)`.
1. Into the input "Amazon S3 URL" you should enter this URL https://hugo-manzoni-labs.s3.amazonaws.com/stacks/pipeline/PipelineECSNestedStack.yaml the press `Next`.
1. You must provide a name for you stack and add a valid email. Please press `Next`.
1. Now press `Next` again, and in Capabilities check the acknowledge checkboxes and then `Submit`.
1. Now you need wait all the stacks be complete.
1. At this point you can clone you repository using the URL (or SSH) which you can find in `Systems Manager` > `Parameter Store` > `/Pipeline/CodeCommit/CloneHTTP` > `Value`
1. You can find the URL Endpoint for your app in `Systems Manager` > `Parameter Store` > `/Pipeline/App/Url` > `Value`

## AWS Architecture Worpress

The architecture of the CI/CD Pipeline is compose by:

1. `CodeCommit`: Used for host your code.
1. `ECR`: Used for store the Docker image.
1. `App LoadBalancer` with `TargetGroup` and `Security Group`: Used for allow it the traffic from internet to your your application hosted in the Container (ECS).
1. `ECS Cluster`: This is used for host all the running ECS Service.
1. `ECS Task Definition` and `ECS Service`: I use this services for define the infrastructure requirements and run the images.
1. `CodeBuild`: Used for build the entire code, update and upload the new docker image into ECR.
1. `CodePipeline`: This service is the orchestrator of CodeCommit, CodeBuild and ECS. Every commit on your code branch will trigger this pipeline, running the CodeBuild and deploying new ECS Service on the Cluster.
1. `EventBridge Rule`: This rule automatically start your pipeline when a change occurs in CodeCommit source repository and branch.

## AWS Architecture diagrams

![App Architecture](https://github.com/hcaman/aws-cfn-stacks/blob/master/nested/pipeline/Arch_diagram.png?raw=true)

## Credits

This idea is entirely based on the project located at https://github.com/acantril/learn-cantrill-io-labs/tree/master/aws-codepipeline-catpipeline. As a means of practice, I converted the idea into a CloudFormation template.
A special thanks goes to Adrian Cantril :smiley:.

<!-- Links -->

[buildspec]: https://docs.aws.amazon.com/codebuild/latest/userguide/build-spec-ref.html
[my-buildspec-file]: https://hugo-manzoni-labs.s3.amazonaws.com/stacks/pipeline/buildspec.yml
