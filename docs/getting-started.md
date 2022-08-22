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
    # Make sure we're using the addon.
    ddev restart
    # Initialize the site.
    ddev dkan-init

Now we have a useful DKAN-based Drupal site, so let's take a look, and use the
standard tools to log in:

    ddev launch
    ddev drush status-report
    ddev drush uli

### TODO

Coming soon: Frontend app installation and build.
