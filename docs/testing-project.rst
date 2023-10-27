Testing your local development project.
=======================================

How to set up your tests
------------------------

Or: An Opinionated Test Runner

This documentation will tell you how to set up your Drupal web site
project so it can be tested in a predictable manner.

If your project layout is correct, you can use these commands to run tests:

.. prompt:: bash $

    ddev project-test-phpunit
    ddev project-test-cypress


PHPUnit setup
^^^^^^^^^^^^^

Your site needs a `phpunit.xml` configuration file for PHPUnit.

A template configuration file is provided in `.ddev/misc/phpunit.xml`.

This file must be placed at `docroot/modules/custom`. It will govern
the PHPUnit configuration for all tests within `docroot/modules/custom`.
PHPUnit will be run within this directory.

You can put this file where it belongs by copying it:

.. prompt:: bash $

    cp .ddev/misc/phpunit.xml docroot/modules/custom

This PHPUnit configuration file defines a test suite called Custom Test Suite.
This suite covers all the tests in the custom modules directory.

Run the tests with this command:

.. prompt:: bash $

    ddev project-test-phpunit

You can add arguments as if you were running the PHPUnit executable:

.. prompt:: bash $

    ddev project-test-phpunit --filter SpecialTest::testSpecialMethod

If you find that your project needs more specialized setup than this
for testing, you can make your own PHPUnit testing command. You can
use `.ddev/commands/web/project-test-phpunit` as a starting point by
copying it, changing the name, and changing the Description and Usage
fields at the top.

Be sure and document the use of this command in your project's `README.md` :-)


Cypress setup
^^^^^^^^^^^^^

Currently, the project Cypress test runner assumes that you have Cypress
installed locally on your machine. The runner will run this version of
Cypress against the DDev environment.

Begin by installing Cypress. For DKAN, we require Cypress 8.7.

.. prompt:: bash $

    npm install --location=global cypress@8.7
    npx cypress verify
    npx cypress info

Next you'll need to set up the site itself, so there is a live site in
DDev to test against.

.. prompt:: bash $

    ddev dkan-init
    ddev dkan-site-install

Other fixture commands may be required before the tests run. For instance,
you may need to run `ddev dkan-test-users` or some other command.

Cypress tests for your site should be in the `tests/cypress` directory,
though this may change.

Now you can run the tests:

.. prompt:: bash $

    ddev project-test-cypress

Much like the PHPUnit command, if you find that your project needs more
specialized setup than this for testing, you can make your own Cypress
testing command. You can use `.ddev/commands/web/project-test-cypress`
as a starting point by copying it, changing the name, and changing the
Description and Usage fields at the top.

Be sure and document the use of this command in your project's `README.md` :-)
