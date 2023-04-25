# backstage-cdk-assets-buildkite-plugin

Simply provides a `post-checkout` hook to enable Backstage `catalog-info.yaml` files to be copied
into our `ops` CDK directory prior to it being built into a Docker image using `docker-compose` plugin

## Example

Add the `cultureamp/backstage-cdk-assets` plugin to your existing CDK build step in your `pipeline.yml`, prior to the `docker-compose` plugin:

```yaml
steps:
- plugins:
  - cultureamp/backstage-cdk-assets#v1.0.0:
  - docker-compose#v3.8.0:
      build: cdk
      config: docker-compose.ci.yml
```

By default the assume your CDK project is at `ops` and the plugin will copy Backstage files into a `.backstage` directory with. Configure the destination path with `dest` parameter:

```yaml
steps:
- plugins:
  - cultureamp/backstage-cdk-assets#v1.0.0:
      dest: ops/cdk     # assets copies into ./ops/cdk/.backstage
  - docker-compose#v3.8.0:
      build: cdk
      config: docker-compose.ci.yml
```

## Developing

To run the tests:

```sh
docker-compose run --rm tests
```

To run linting:

```sh
docker-compose run --rm lint
```
