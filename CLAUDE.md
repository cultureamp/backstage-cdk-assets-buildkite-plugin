# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

### Testing

- Run tests: `docker-compose run --rm tests`
- Tests use BATS (Bash Automated Testing System) located in `tests/post-checkout.bats`

### Linting

- Run linting: `docker-compose run --rm lint`
- Uses buildkite/plugin-linter with plugin ID `cultureamp/backstage-cdk-assets`

## Architecture

This is a Buildkite plugin that copies Backstage `catalog-info.yaml` files into a CDK directory structure during the CI/CD process.

### Core Components

1. **Plugin Configuration** (`plugin.yml`): Defines the plugin schema with optional `source` and `dest` parameters
2. **Main Hook** (`hooks/post-checkout`): The primary script that executes during Buildkite's post-checkout phase
3. **Shared Utilities** (`lib/shared.bash`): Contains helper functions for reading plugin configuration from environment variables

### Data Flow

1. Plugin reads configuration from environment variables prefixed with `BUILDKITE_PLUGIN_BACKSTAGE_CDK_ASSETS_`
2. Defaults: source=`./`, dest=`./ops`
3. Copies all `catalog-info*.y*ml` files from source directory to `{dest}/.backstage/`
4. Creates destination directory if it doesn't exist, removes it if it does

### Key Functions

- `plugin_read_config()` in `lib/shared.bash:6`: Reads environment variables with fallback defaults
- `cleanPath()` in `hooks/post-checkout:21`: Normalizes directory paths to ensure proper formatting
- `main()` in `hooks/post-checkout:9`: Primary execution logic for file copying

### Testing Strategy

Tests use stubbing to mock file system operations (`rm`, `mkdir`, `cp`) and verify correct command execution with various configuration combinations.

## MCP Rules

- When using Context7 maintain a file named library.md to store a Library IDs that you search for and before searching make sure that you check the file and use the library ID already available. Otherwise search for it.
