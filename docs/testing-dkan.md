# Testing the DKAN module

## Testing with PHPUnit

Your process should set up the site:

    ddev dkan-init
    # optionally: ddev dkan-init --moduledev
    ddev dkan-site-install

Then run the tests:

    ddev dkan-phpunit

The tests will run by default with xdebug in "coverage" mode, to facilitate building
coverage reports in XML or HTML. If you want to use a step debugger locally, add the
`--debug` flag before any other flags or arguments.

## Testing with Cypress locally

You will need a locally-installed Cypress binary, version 8. (DKAN frontend
and module tests currently require Cypress 8.7)

    npm install --location=global cypress@8.7
    npx cypress verify
    npx cypress info

Now use ddev to build a site and then test it.

    mkdir myproject && cd myproject
    ddev config --auto
    ddev get getdkan/ddev-dkan
    ddev restart
    ddev dkan-init
    ddev dkan-site-install

Now you can test the site:

    ddev dkan-module-test-cypress

And you can substitute the local dev DKAN module in this scenario as well:

    mkdir myproject && cd myproject
    ddev config --auto
    ddev get getdkan/ddev-dkan
    ddev restart
    ddev dkan-init --moduledev
    cd dkan
    git checkout my_feature_branch
    ddev dkan-site-install
    # Work on the module....
    ddev dkan-module-test-cypress
    # Work on the module....
    ddev dkan-module-test-cypress
    # etc.
