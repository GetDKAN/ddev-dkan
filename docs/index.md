---
title: "DDEV-DKAN add-on"
---

The DDEV-DKAN add-on provides configuration and specialized commands for developing and maintaining a DKAN Drupal project
in a containerized environment.

- [Docker Documentation](https://docs.docker.com/desktop/)
- [DDEV Documentation](https://ddev.readthedocs.io/en/stable/users/usage/)
- [Drupal Documentation](https://www.drupal.org/docs/getting-started/system-requirements)
- [DKAN Documentation](https://dkan.readthedocs.io/en/latest/index.html)

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
- [Build a DKAN demo site](demo.md)
- [Convert a DKAN-Tools project to DDEV](dktl-convert.md)
- [Testing the DKAN module](testing-dkan.md)
- [Debugging PHPUnit tests in DDEV](testing-debug-phpunit.md)
- [Testing your local development project](testing-project.md)
