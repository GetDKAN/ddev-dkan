---
title: "DDEV-DKAN add-on"
---

The DDEV-DKAN add-on provides configuration and specialized commands for dealing
with a DKAN Drupal project in the DDEV environment.

Note that all the DKAN commands which come with this addon have documentation built-in. At the command line, you can
ask for help with any one of them with `ddev [command] --help` like this:

    $ ddev dkan-init --help
    Build the Drupal codebase for a DKAN site. (shell host container command)

    Usage:
    ddev dkan-init [flags]

    Flags:
    -h, --help        help for dkan-init
    --moduledev   Set up the file system for DKAN module development.

    Global Flags:
    -j, --json-output   If true, user-oriented output will be in JSON format.

## Sections:

- [Getting started](getting-started.md)
- [Create a demo DKAN site](demo.md)
- [Convert a DKAN-Tools project to DDEV](dktl-convert.md)
- [Testing the DKAN module](testing-dkan.md)
- [Debugging PHPUnit tests in DDev](testing-debug-phpunit.md)
- [Testing your local development project](testing-project.md)
- [Generate DKAN Documentation](docs.md)
