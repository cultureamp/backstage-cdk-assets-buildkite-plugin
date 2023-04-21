#!/usr/bin/env bats

setup() {
  load "$BATS_PLUGIN_PATH/load.bash"

  # Uncomment to enable stub debugging
  # export GIT_STUB_DEBUG=/dev/tty
}

setup_stubs() {
  stub rm \
    ':: echo stubbed rm $@'
  stub mkdir \
    ':: echo stubbed mkdir $@'
  stub cp \
    ':: echo stubbed cp $@'
}

teardown_stubs() {
  unstub rm
  unstub mkdir
  unstub cp
}

@test "it copies .yaml files to ops by default" {
  setup_stubs

  run "$PWD/hooks/post-checkout"

  assert_success
  assert_line --partial "stubbed rm -rf ./ops/.backstage"
  assert_line --partial "stubbed mkdir -p ./ops/.backstage"
  assert_line --partial "stubbed cp catalog-info*.y*ml ./ops/.backstage"

  teardown_stubs
}

@test "it copies .yaml files to provided dest directory" {
  setup_stubs
  export BUILDKITE_PLUGIN_BACKSTAGE_CDK_ASSETS_DEST="./ops/cdk"

  run "$PWD/hooks/post-checkout"

  assert_success
  assert_line --partial "stubbed rm -rf ./ops/cdk/.backstage"
  assert_line --partial "stubbed mkdir -p ./ops/cdk/.backstage"
  assert_line --partial "stubbed cp catalog-info*.y*ml ./ops/cdk/.backstage"

  teardown_stubs
}
