# Getting started with DKAN DDev Addon

## Start a new DKAN site

First set up for using DKAN:

    # Make a directory for your project.
    mkdir my-project && cd my_project
    # Give DDev just enough configuration to get started.
    ddev config --auto
    # Use DDev to build the template project using Composer.
    ddev composer create getdkan/recommended-project:@dev --no-interaction -y
    # Grab the addon so you get the fun stuff.
    ddev get getdkan/dkan-ddev-addon
    # Restart so DDev can make sure everything's where it should be.
    ddev restart

If you now type `ddev launch` you'll see that the server is available, and Drupal
will prompt you to install the site. However, we should use Drush to do that,
shouldn't we?

    ddev drush site:install -y
    ddev drush pm-enable dkan -y

Now we have a useful DKAN-based Drupal site, so let's take a look, and use the
standard tools to log in:

    ddev launch
    ddev status-report
    ddev drush uli

### TODO

Coming soon: Frontend app installation and build.
