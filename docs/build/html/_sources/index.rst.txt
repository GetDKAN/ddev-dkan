DKAN DDev Addon
===============

The DKAN DDEv Addon provides configuration and specialized commands for dealing
with a DKAN Drupal project in the DDEv environment.

Note that all the DKAN commands which come with this addon have documentation built-in. At the command line, you can
ask for help with any one of them with `ddev [command] --help` like this:

.. code-block::

    ddev dkan-init --help
    Build the Drupal codebase for a DKAN site. (shell host container command)

    Usage:
    ddev dkan-init [flags]

    Flags:
    -h, --help        help for dkan-init
    --moduledev   Set up the file system for DKAN module development.

    Global Flags:
    -j, --json-output   If true, user-oriented output will be in JSON format.

.. toctree::
   :maxdepth: 1

   getting-started
   frontend
   demo
   dktl-convert
   testing-debug-phpunit
   testing-dkan
   testing-project

