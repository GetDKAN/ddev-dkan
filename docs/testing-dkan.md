# Testing the DKAN module

Currently, PHPUnit testing is supported by the DKAN DDev Addon.

Your process should set up the site:

    ddev dkan dkan-init
    # optionally: ddev dkan-init --moduledev
    ddev dkan-site-install

Then run the tests:

    ddev dkan dkan-test-phpunit

This command will call the `dkan-test-users` command to create test users.

### TODO

Coming soon: Testing with Cypress.
