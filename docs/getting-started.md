# Getting started with DKAN DDev Addon

## Start a new DKAN site

First, set up your DKAN site:

    # Make a directory for your project.
    mkdir my-project && cd my_project
    # Give DDev just enough configuration to get started.
    ddev config --auto
    # Grab the addon so you get the fun stuff.
    # Note that eventually we'll be 'official' and you won't have
    # to install this from a tarball.
    ddev get https://github.com/GetDKAN/dkan-ddev-addon/archive/refs/heads/main.tar.gz
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

## Dev work on the DKAN module

If you are doing development work on the DKAN module itself, you can substitute
the `ddev dkan-init --moduledev` command for `ddev dkan-init`.

This will clone the dkan project into its own directory and tell Composer to
use that repo as the getdkan/dkan package.

### TODO

Coming soon: Frontend app installation and build.
