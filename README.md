[![tests](https://github.com/getdkan/dkan-ddev-addon/actions/workflows/tests.yml/badge.svg)](https://github.com/drud/ddev-dkan-ddev-addon/actions/workflows/tests.yml) ![project is maintained](https://img.shields.io/maintenance/yes/2022.svg)

## What is dkan-ddev-addon?

Next time you're doing a ddev local development site, you can say this:
```shell
ddev get getdkan/dkan-ddev-addon
ddev restart
```
Now you will have configuration and commands for many DKAN needs.

## TODO: All the docs for your reading enjoyment.

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
