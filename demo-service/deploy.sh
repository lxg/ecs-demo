#!/bin/bash

set -e

source ../.env

stackName="$STACK_PREFIX-service"
ecrRepoName="$STACK_PREFIX-base-infra-ecr-services" # see base-infra folder
serviceName=demo-service
serviceVersion=latest
imageName="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$ecrRepoName:${serviceName}_${serviceVersion}"

# NOTE: The image name will be something like base-infra-ecr-services:demo-service_latest
# We use "services" as the name of the service and "demo-service_latest" as the version, which is weird by Docker standards
# but is a conscious choice here, because otherwise we would have to create one repository per service in ECR
# which would require to deploy and maintain infrastructure for each single service.

aws ecr get-login-password | docker login --username AWS --password-stdin "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com"
docker build -t $imageName .
docker push $imageName

aws cloudformation deploy \
    --stack-name=$stackName \
    --template-file=cloudformation.yml \
    --capabilities CAPABILITY_IAM \
    --no-fail-on-empty-changeset \
    --parameter-overrides \
        pathPrefix=$serviceName \
        ecsTaskImage=$imageName \
        albPrio=10
