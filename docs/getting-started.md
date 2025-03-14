# Getting started with DDEV-DKAN add-on

## Start a new DKAN site

First, make a directory for your project.

    mkdir my-project && cd my-project

Give DDEV just enough configuration to get started.

    ddev config --auto

Grab the DKAN add-on to get helpful DKAN commands.

    ddev add-on get getdkan/ddev-dkan

Make sure we're using the add-on.

    ddev restart

Initialize the site. The current default Drupal version is 10.3.x
To initialize DKAN for a different version of Drupal, add --project-version
to the following command like '--project-version 11.0.x-dev'.

    ddev dkan-init


> [!NOTE]
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
Now install Drupal.

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

Run `ddev add-on list` to get a list of other DDEV add-ons.
