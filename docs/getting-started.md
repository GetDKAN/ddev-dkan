# Getting started with DDEV-DKAN add-on

## Start a new DKAN site

First, make a directory for your project.

    mkdir my-project && cd my-project

Give DDEV just enough configuration to get started.

    ddev config --auto

Grab the DKAN add-on to get helpful DKAN commands.

    ddev add-on get getdkan/ddev-dkan

For DDEV versions older than v1.23.5, run `ddev get getdkan/ddev-dkan`.
Make sure we're using the add-on.

    ddev restart

### Initialize the site.
The dkan-init command will set up a Drupal 10.4.x build.

    ddev dkan-init

To initialize DKAN for a different version of Drupal, add the `--project-version` flag to specify a different version of Drupal.

    ddev dkan-init --project-version 11.1.x-dev


> **NOTE**
>
> If you are doing module development use the _--moduledev_ flag.
>
> This will clone the dkan project into its own directory at the root of the project
> and tell Composer to use that repo as the getdkan/dkan package.
>
>   `ddev dkan-init --moduledev`
>
> You can make edits to this directory to create PRs on dkan.

This will ask you if it's OK to remove most of the files in your project.
You can answer yes since there's nothing there right now anyway.

You can modify your project build by adding your own config.{project}.yaml file to override the .ddev/config.yaml.
Or update the config.yaml with the ddev config commands, such as:

    ddev config --php-version=8.4

The database will be mysql:5.7 at this point, you can change this to any of the supported [database types](https://ddev.readthedocs.io/en/stable/users/extend/database-types/).

    ddev debug migrate-database mysql:8.0

### Install Drupal.

    ddev dkan-site-install

Now we have a Drupal site with DKAN enabled, use the
standard commands to log in:

    ddev launch
    ddev drush status-report
    ddev drush uli

Note that if you need help with any of the DDEV commands, you can add `--help`
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

DKAN can integrate with a JS/headless app. The DKAN DDEV add-on has special
commands for dealing with this.

### Install

First we gather all the dependencies and files necessary for the frontend:

    ddev dkan-frontend-install

### Build

Now that you have all the dependencies, you can build the frontend:

    ddev dkan-frontend-build

Currently this command essentially calls `npm run build` within the web container
of DDEV.

## Additional Commands

Run `ddev` by itself to get a list of commands available to you.

Run `ddev add-on list --all` to get a list of other DDEV add-ons.
