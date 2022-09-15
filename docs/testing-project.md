# Testing your local development project.

## How to set up your tests

Or: An Opinionated Test Runner

This documentation will tell you how to set up your Drupal web site
project so it can be tested in a predictable manner.

If your project layout is correct, you can use these commands to run tests:

    ddev project-test-phpunit
    ddev project-test-cypress

### PHPUnit setup

Your site needs a `phpunit.xml` configuration file for PHPUnit.

A template configuration file is provided in `.ddev/misc/phpunit.xml`.

This file must be placed at `docroot/modules/custom`. It will govern
the PHPUnit configuration for all tests within `docroot/modules/custom`.
PHPUnit will be run within this directory.

You can put this file where it belongs by copying it:

    cp .ddev/misc/phpunit.xml docroot/modules/custom

This PHPUnit configuration file defines a test suite called Custom Test Suite.
This suite covers all the tests in the custom modules directory.

If you find that your project needs more specialized setup than this
for testing, you can make your own PHPUNit testing command. You can
use `.ddev/commands/web/project-test-phpunit` as a starting point by
copying it, changing the name, and changing the Description and Usage
fields at the top.

Be sure and document the use of this command in your project's `README.md` :-)


### Cypress setup

TODO: Cypress
