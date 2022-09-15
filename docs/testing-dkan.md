# Testing the DKAN module

## Testing with PHPUnit

Your process should set up the site:

    ddev dkan dkan-init
    # optionally: ddev dkan-init --moduledev
    ddev dkan-site-install

Then run the tests:

    ddev dkan dkan-test-phpunit

This command will call the `dkan-test-users` command to create test users.

## Testing with Cypress locally

You will need a locally-installed Cypress binary, version 8. (DKAN frontend
and module tests currently require Cypress 8.7)

    npm install --location=global cypress@8.7
    npx cypress verify
    npx cypress info

Now use ddev to build a site and then test it.

    mkdir myproject && cd myproject
    ddev config --auto
    ddev get https://github.com/GetDKAN/dkan-ddev-addon/archive/refs/heads/main.tar.gz
    ddev restart
    ddev dkan-init
    ddev dkan-site-install

Now you can test the site:

    ddev dkan-module-test-cypress

And you can substitute the local dev DKAN module in this scenario as well:

    mkdir myproject && cd myproject
    ddev config --auto
    ddev get https://github.com/GetDKAN/dkan-ddev-addon/archive/refs/heads/main.tar.gz
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
