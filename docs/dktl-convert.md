# Convert DKAN-Tools project to DDEV

Note: This documentation is incomplete.

## Codebase:

### Prepare the site for conversion

The main steps here would be to ensure a fresh config export and add it to your repo. This might or might not be
necessary, but is probably a best practice anyway.

### Get the web root from composer.json.

Look at the project composer.json file. It will likely have an `extra.drupal-scaffold.locations.web-root` configuration.

Make a note of that. It's probably `docroot/`

### Initially configure DDEV.

Use the web root information to configure DDEV:

    cd your_project_root
    ddev config --project-type drupal9 --docroot YOUR_WEBROOT_VALUE --create-docroot

This command will set up an initial state of configuration. We're going to override this with the dkan-ddev-addon in
the next step, but DDEV requires that we do this first.

### Get the DKAN DDEV addon.

    ddev get https://github.com/GetDKAN/dkan-ddev-addon/archive/refs/heads/main.tar.gz
    ddev restart

This will pull down some configuration and scripts. We must then restart the DDEV environment after this.

### Set up `.gitignore`.

For now, we'll just delete the current `.gitignore` for the project and only ignore the vendor directory. Alternately,
if you don't want to lose the contents of `.gitignore` you could rename it.

    rm .gitignore
    # Alternately: mv .gitignore old.gitignore
    echo "vendor/" >> .gitignore

This will cause the Drupal Composer Scaffold plugin to add scaffolded files to the `.gitignore` file, which we want.

We'll fill out the rest of the `.gitignore` file at the end.

### Update Scaffold plugin and initial Composer install.

Let's make sure we're not limiting ourselves to an old version of Drupal Composer Scaffold plugin.

    ddev composer require drupal/core-composer-scaffold:^9 --no-install

Now let's use DDEV to run `composer install`, so it can build out some directories for us, to make subsequent steps easier.

    ddev composer install

During this process, Composer might ask you if it's OK for plugins to run, and it's probably OK to answer yes. You might
end up answering 'yes' to a number of questions like this:

    Do you trust "drupal/core-composer-scaffold" to execute code and wish to enable it now?
    (writes "allow-plugins" to composer.json) [y,n,d,?]

### Manage the modules and themes.

The repo likely contains a `src/` directory, and within that `src/modules`. This is where the custom modules for your
site live.

Assuming the site has `docroot/` directory, we'll move those to `docroot/modules/custom`. (If your site has a different
web root directory, use that instead.) When we're done, the contents of `src/modules` should be inside
`docroot/modules/custom`.

We'll do the same thing for themes, as well.

    mv src/modules docroot/modules/custom
    mv src/themes docroot/themes/custom

### Settings..? Settings.

Let's state up-front that it's complicated here.

First of all, we'll follow the instructions for the DKAN DDEV addon, and add the DKAN-specific config to settings.php.

    cat .ddev/misc/settings.dkan-snippet.php.txt >> docroot/sites/default/settings.php
    cp .ddev/misc/settings.dkan.php docroot/sites/default/settings.dkan.php

It's entirely likely that your project has a `src/site/` directory. You'll note also that DDEV helpfully gave you a
`docroot/sites/default/settings.php` file, along with a `settings.ddev.php` file. We also now have a `settings.dkan.php`
file.

Now is the time when you have to reconcile your project's settings files against these.

Examine `src/site/settings.php` and determine what is needed to be moved over to `docroot/sites/default/settings.php`,
or what could be another external file which is loaded by `settings.php`.

Candidates for things which are important might include config sync location, and the site hash value.

### A complete codebase? Let's try and install...

Well, maybe our codebase isn't complete. Did you already have Drush? Let's ask Composer.

    ddev composer show drush/drush | grep versions

If you don't see a version number, add Drush:

    ddev composer require drush/drush

OK, *now* we can install a site. If your site uses the DKAN module, use `ddev dkan-site-install`. Otherwise just use Drush.

    ddev dkan-site-install
    # or...
    ddev drush site-install -y

This gives us a plain-vanilla Drupal installation. Launch it and behold its beauty:

    ddev launch

Note that we're seeing aggregated CSS and JS being sent with a MIME type of text/hml,
which modern browsers refuse to show. If your site looks like it doesn't have CSS,
you can use Drush to turn off aggregation, for now:

    ddev drush -y config-set system.performance css.preprocess 0
    ddev drush -y config-set system.performance js.preprocess 0

Log in if you'd like:

    ddev drush uli

### Import our config

This is really two steps. The site we're converting probably has some special commands required to get it into a
state for importing the configuration, so we'll explore that first.

#### Replicate DKAN-Tools Install Process

Your DKAN-Tools site might have some installation steps in its commands. So look at `src/command`, and look for
a command method such as `YoursiteInstall()`. This probably has some Drush commands which you should emulate.

For instance, here's a custom DKAN-Tools command from a project:

    class MyprojectCommands extends Tasks
    {
      public function MyprojectInstall() {
        `dktl install`;
        `dktl drush entity:delete shortcut_set`;
        `dktl drush pmu shortcut`;
        `dktl drush config:set system.site uuid [YOUR UUID HERE] -y`;
        `dktl drush ci -y`;
        `chmod u+w docroot/sites/default`;
        `dktl drush cr`;
        return $this->taskExec('dktl drush cc drush')
          ->dir(Util::getProjectDocroot())
          ->run();
      }
    }

From this we can remove the `dktl install` command (since that's the same as `ddev dkan-site-install`), and then
extract the rest and replace `dktl` with `ddev` to run Drush. This give us a list like this:

    ddev drush entity:delete shortcut_set
    ddev drush pmu shortcut
    ddev drush config:set system.site uuid [YOUR UUID HERE] -y
    ddev drush ci -y
    chmod u+w docroot/sites/default
    ddev drush cr
    ddev drush cc drush

It might be that we don't need all of these, such as the `chmod`, or two different cache clear commands. I'm about
to tell you to do `drush ci` so it might also be unneeded at this point.

Now you should perform these commands against the installed site in order to prepare it to import the site
configuration.

For bonus points, you can [convert this command to a DDEV command](https://ddev.readthedocs.io/en/latest/users/extend/custom-commands/)
which users can then use from then on whenever you install Drupal.

#### Import Site Configuration

Now that you've replicated your site's DKAN-Tools install command, you can import the site config.

    ddev drush cim

### Did it work?

Let's find out:

    ddev drush cr
    ddev launch

Handy commands for finding out what went wrong include:

    ddev logs

### Finalize `.gitignore` for the repo

We can see that Drupal core has provided us with a handy file called `docroot/example.gitignore`.

We can copy this file to be `docroot/.gitignore` and it will hide files from Git, such as configuration and public file
directories.

We also want to read that file, so we can fully understand what it does, and modify it for our project-related needs.

    mv docroot/example.gitignore docroot/.gitignore
    # Read and modify docroot/.gitignore as needed...

Alternately, we could move all the rules from `example.gitignore` to our root-level `.gitignore`. Whether to do this
is an exercise left to the leader of your project.

Also we should visit our top-level `.gitignore` file so we can be sure we don't exclude or include the wrong files.

Here's a `.gitignore` file which leaves out all the things you can rebuild with Composer.

    vendor/
    /.editorconfig
    /.gitattributes
    docroot/core
    docroot/libraries
    docroot/modules/contrib
    docroot/themes/contrib

You probably want to exclude IDE settings:

    .idea/

