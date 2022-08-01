# Getting started with DKAN DDev Addon

## NOTE: During development....

Instead of `ddev get getdkan/dkan-ddev-addon`, use the tarball file from the repo, like this:

    ddev get https://github.com/GetDKAN/dkan-ddev-addon/archive/refs/heads/main.tar.gz

If you desire a different addon repo branch, substitute its name for 'main.'

TODO: Make a release and add the addon tag to our repo so DDev can find it.

## Start a new DKAN site

First set up for using DKAN:

    # Make a directory for your project.
    mkdir my-project && cd my_project
    # Give DDev just enough configuration to get started.
    ddev config --auto
    # Grab the addon so you get the fun stuff.
    ddev get getdkan/dkan-ddev-addon
    # Use DDev to build the template project using Composer.
    ddev composer create getdkan/recommended-project:@dev --no-interaction -y
    # At this point, we must add a configuration to settings.php
    # This should change after DDev 1.19.6 is released.
    cat .ddev/misc/settings.dkan-snippet.php.txt >> docroot/sites/default/settings.php
    cp .ddev/misc/settings.dkan.php docroot/sites/default/settings.dkan.php
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
    ddev drush status-report
    ddev drush uli

### TODO

Coming soon: Frontend app installation and build.
