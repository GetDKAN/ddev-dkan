# Convert DKAN-Tools project to DDEV

Note: This documentation is incomplete.

## Codebase:

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

### Update Scaffold plugin and initial Composer install.

Let's make sure we're not limiting ourselves to an old version of Drupal Composer Scaffold plugin.

    ddev composer require drupal/core-composer-scaffold:^9 --no-install

Now let's use DDEV to run `composer install`, so it can build out some directories for us, to make subsequent steps easier.

    ddev composer install

During this process, Composer might ask you if it's OK for plugins to run, and it's probably OK to answer yes.

### Manage the modules

The repo likely contains a `src/` directory, and within that `src/modules`. This is where the custom modules for your
site live.

We'll move those to `docroot/modules/custom`. When we're done, the contents of `src/modules` should be inside
`docroot/modules/custom`.

We'll also add the contrib modules to `.gitignore` so that we don't check them into the repository.

    mv src/modules docroot/modules/custom
    echo "docroot/modules/contrib" >> .gitignore

### Manage the themes

Same thing with the themes as the modules.

Our Composer Installers configuration probably is set to load contrib themes into `docroot/themes/contrib`, and we want
our custom themes to go into `docroot/themes/custom`.

And we also want to not put our contrib themes in the codebase, so we'll modify `.gitignore`.

    mv src/themes docroot/themes/custom
    echo "docroot/themes/contrib" >> .gitignore

### More .gitignore

By now, our `.gitignore` should look something like this:

    vendor/
    /.editorconfig
    /.gitattributes
    docroot/modules/contrib
    docroot/themes/contrib

But we still want to add some more to it.

    echo "docroot/core" >> .gitignore
    echo "docroot/libraries" >> .gitignore

TODO: Should we check in the frontend app?

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

### A complete codebase? Let's try and install...

Well, maybe our codebase isn't complete. Did you already have Drush? Let's ask Composer.

    ddev composer show drush/drush | grep versions

If you don't see a version number, add Drush:

    ddev composer require drush/drush

OK, *now* we can install a site.

    ddev drush site-install -y

This gives us a
