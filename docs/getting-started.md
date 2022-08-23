# Getting started with DKAN DDev Addon

## NOTE: During development....

Instead of `ddev get getdkan/dkan-ddev-addon`, use the tarball file from the repo, like this:

    ddev get https://github.com/GetDKAN/dkan-ddev-addon/archive/refs/heads/main.tar.gz

If you desire a different addon repo branch, substitute its name for 'main.'

TODO: Make a release and add the addon tag to our repo so DDev can find it.

## Start a new DKAN site

First, set up your DKAN site:

    # Make a directory for your project.
    mkdir my-project && cd my_project
    # Give DDev just enough configuration to get started.
    ddev config --auto
    # Grab the addon so you get the fun stuff.
    ddev get getdkan/dkan-ddev-addon
    # Make sure we're using the addon.
    ddev restart
    # Initialize the site.
    ddev dkan-init
    # Install Drupal.
    ddev dkan-site-install

Now we have a useful DKAN-based Drupal site, so let's take a look, and use the
standard tools to log in:

    ddev launch
    ddev drush status-report
    ddev drush uli

If you are doing development work on the DKAN module itself, you can substitute
the `ddev dkan-init --moduledev` command for `ddev dkan-init`.

This will clone the dkan project into its own directory and tell Composer to
use that repo as the getdkan/dkan package.

### TODO

Coming soon: Frontend app installation and build.
