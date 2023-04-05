# Getting started with DKAN DDev Addon

## Start a new DKAN site

First, make a directory for your project.

    mkdir my-project && cd my-project

Give DDev just enough configuration to get started.

    ddev config --auto

Grab the DKAN addon to get helpful DKAN commands.
Note that eventually we'll be 'official' and you won't have
to install this from a tarball.

    ddev get https://github.com/GetDKAN/dkan-ddev-addon/archive/refs/heads/main.tar.gz

Make sure we're using the addon.

    ddev restart

Initialize the site.

    ddev dkan-init

This will ask you if it's OK to remove most of the files in your project.
You can answer yes since there's nothing there right now anyway.
Now install Drupal.

    ddev dkan-site-install

Now we have a useful DKAN-based Drupal site, so let's take a look, and use the
standard tools to log in:

    ddev launch
    ddev drush status-report
    ddev drush uli

Note that if you need help with any of the DDev commands, you can add `--help`
on the command line and get help:

    ddev dkan-init --help
    Build the Drupal codebase for a DKAN site. (shell host container command)

    Usage:
        ddev dkan-init [flags]

    Examples:
        dkan-init
        dkan-init --project-version 10.0.x-dev

    Flags:
    --force             Force init even if there are files present which could be deleted.
    -h, --help          help for dkan-init
    --moduledev         Set up the file system for DKAN module development.
    --project-version   Specify a Drupal core version. Default 9.5.x-dev.

    Global Flags:
    -j, --json-output   If true, user-oriented output will be in JSON format.

## Contributing to DKAN

If you are doing development work on the DKAN module itself, add the --moduledev flag to the dkan-init command:

    ddev dkan-init --moduledev

This will clone the dkan project into its own directory and tell Composer to
use that repo as the getdkan/dkan package.

## Decoupled Frontend app installation and build

DKAN can integrate with a JS/headless app. The DKAN DDev addon has special
commands for dealing with this.

### Install

First we gather all the dependencies and files necessary for the frontend:

    ddev dkan-frontend-install

### Build

Now that you have all the dependencies, you can build the frontend:

    ddev dkan-frontend-build

Currently this command essentially calls `npm run build` within the web container
of DDev.

## Additional Commands

Run `ddev` by itself to get a list of commands available to you.

Run `ddev get --list --all` to get a list of other DDEV add-ons.
## Additional Resources

- [DDEV Documentation](https://ddev.readthedocs.io/en/stable/users/usage/)
- [DKAN Documentation](https://demo.getdkan.org/modules/contrib/dkan/docs/index.html)
