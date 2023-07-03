# ECS Example Stack

This is an example of an Amazon Elasic Container Service (ECS) setup. It contains base infrastucture, to be found in the [`base-infra`](/base-infra) folder, as well as an example of a containerised service to be run on the cluster, in the [`demo-service`](/demo-service) folder. In a real-world setup, these would be two distinct projects, and multiple independent services could be run on the base infrastucture.

**Attention** Deploying this demo on AWS will incur costs for the time it is running; the concrete amount depends on factors such as the choosen region and the time it is online. Please review the infrastructure before deployment and delete it after trying it out, as described in the “Clean Up” chapter below.

**NO WARRANTY** Use this repository at your own risk.

## Base Infrastucture

 For base infrastructure, it contains a full [VPC](https://aws.amazon.com/vpc/), an [ALB](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html), an [ECR](https://aws.amazon.com/ecr/) and the ECS cluster itself.

### Deployment

The deployment will create four independent stacks in your AWS account. It assumes you have the `aws` CLI tool installed and have it configured with credentials for full administrative access.

To deploy the base infrastructure, first edit the `.env` file and insert the account ID, a hosted zone ID and a domain name. This assumes you have an existing hosted zone setup and you are able to deploy the given (sub-)domain name into it.

### Demo Service

As soon as the base infrastructure is deployed, you can deploy the demo service. This is a little NodeJS server that will create a file inside the container and return a simple JSON payload.

If everything was deployed successfully, you should be able to access the service under `https://subdomain.example.com/demo-service/` (assuming that `subdomain.example.com` has been configured in the hosted zone and that you have set up DNS to resolve to that host name).

## Clean Up

To clean up all deployed infrastructure and stop incurring cost, proceed as follows:

- Go to the [ECR page](https://console.aws.amazon.com/ecr/repositories) and delete all images from the ECR registry for the demo repository.
- Go to the [CloudFormation page](https://console.aws.amazon.com/cloudformation/home) and delete the demo stacks in reverse order. Wait for each stack to be completely deleted before deleting the next one, in order to have dependencies removed.

This will also delete the demo service deployed on the ECS cluster.

## Issues

In case of any issues, please open a bug report on this repository.