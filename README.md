[![tests](https://github.com/GetDKAN/ddev-dkan/actions/workflows/tests.yml/badge.svg)](https://github.com/GetDKAN/ddev-dkan/actions/workflows/tests.yml) ![project is maintained](https://img.shields.io/maintenance/yes/2025.svg)

> [!IMPORTANT]
> As of DKAN v2.22, we recommend the DDEV [Drupal Contrib add-on](https://github.com/ddev/ddev-drupal-contrib) and workflow to work directly on the DKAN codebase. This will let you clone the module directly from its git repository and stand up a minimal site around it with a flexible stack and no need to manage an entire website codebase.

## What is ddev-dkan?

DDEV-DKAN add-on provides commands and config for development of
DKAN itself and DKAN-enabled Drupal sites in a local docker environment.

## Documentation

Documentation lives in Github Pages: https://getdkan.github.io/ddev-dkan/

## Testing

This addon uses [BATS](https://bats-core.readthedocs.io/en/stable/) for testing.

Get the BATS system by running:
```shell
sh ./setup-bats.sh
```

Now run the tests:
```shell
./tests/bats/bin/bats tests/
```

These tests will run on every push to the Github repo.
