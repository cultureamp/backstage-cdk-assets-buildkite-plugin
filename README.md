# backstage-cdk-assets-buildkite-plugin

Simply provides a `post-checkout` hook to enable Backstage `catalog-info.yaml` files to be copied
into our `ops` CDK directory prior to it being built into a Docker image using `docker-compose` plugin

## Example

Add the `cultureamp/backstage-cdk-assets` plugin to your existing CDK build step in your `pipeline.yml`, prior to the `docker-compose` plugin:

```yml
steps:
- plugins:
  - cultureamp/backstage-cdk-assets#v1.0.0:
  - docker-compose#v3.8.0:
      build: cdk
      config: docker-compose.ci.yml
```
