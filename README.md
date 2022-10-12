[![tests](https://github.com/getdkan/dkan-ddev-addon/actions/workflows/tests.yml/badge.svg)](https://github.com/drud/ddev-dkan-ddev-addon/actions/workflows/tests.yml) ![project is maintained](https://img.shields.io/maintenance/yes/2022.svg)

## What is dkan-ddev-addon?

DKAN DDev Addon provides some glue scripts and config for doing local development of
DKAN itself and also DKAN-related Drupal sites.

## Documentation

Documentation lives in Github Pages: https://getdkan.github.io/dkan-ddev-addon/

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
