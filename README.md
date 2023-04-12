# backstage-cdk-assets-buildkite-plugin

Simply provides a `post-checkout` hook to enable Backstage `catalog-info.yaml` files to be copied
into our `ops` CDK directory prior to it being built into a Docker image using `docker-compose` plugin

## Example

Add the `cultureamp/backstage-cdk-assets` plugin to your  existing CDK build step in your `pipeline.yml`, prior to the `docker-compose` plugin:

```yml
steps:
  - label: ":docker: CDK Build"
    key: cdk_build
    branches: "*"
    agents:
      queue: $BUILD_AGENT
    plugins:
      - cultureamp/aws-assume-role:
          role: $BUILD_ROLE
      - ecr#v1.2.0:
          login: true
          account_ids: ${CI_AWS_ACCOUNT_ID}
      - cultureamp/backstage-cdk-assets:
      - docker-compose#v3.8.0:
          build: cdk
          config: docker-compose.ci.yml
          image-repository: ${ECR_REPO}
          image-name: cdk-${BUILDKITE_BUILD_NUMBER}
      - cultureamp/ecr-scan-results#v1.1.7:
          image-name: "${ECR_REPO}:cdk-${BUILDKITE_BUILD_NUMBER}"
```
