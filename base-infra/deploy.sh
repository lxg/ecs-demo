#!/bin/bash

set -e

source ../.env

for stack in vpc alb ecr ecs; do
  stackName="$STACK_PREFIX-base-infra-$stack"
  echo -e "----\n\nDeploying $stackName … "

  aws cloudformation deploy \
    --stack-name=$stackName \
    --template-file=$stack.yml \
    --no-fail-on-empty-changeset \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameter-overrides \
      hostedZoneId=$HOSTED_ZONE_ID \
      domainName=$DOMAIN_NAME

  echo "Deployed $stackName."
done