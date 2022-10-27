# Debugging a PHPUnit test with DDev

This documentation is specific to using the DKAN DDev addon, but can be
generalized for many other use-cases.

Currently, we're only going to talk about using PHPStorm. Do you have
instructions for another IDE? Make a pull request. :-)

## Hashtag-debugging-goals...

We want to be able to use our DDev environment to do step-debugging for PHPUnit-based tests, using PHPStorm.

There are three main moving parts in this process:
- The remote PHP interpreter.
- The PHPUnit framework configuration.
- The Run/Debug test runner.

## 1. Set up the remote PHP interpreter

We *could* spend a lot of time working really hard to set up the remote PHP
interpreter configuration in PHPStorm to use our DDev environment.

Or, we could install the DDev Integration plugin.

The plugin is the better choice. It will configure a remote interpreter for you,
and you're done. It also gives you some UI clicky things to start and stop
DDev environments.

## 2. Configure the PHPUnit framework

This step will generally tell PHPStorm how to deal with PHPUnit. We're using this to
enable step debugging, but this also unlocks some nice features such as in-document
test coverage reporting.

- Select PHPStorm -> Preferences.
- Choose the PHP -> Test Frameworks tab.
- Click +.
- Add 'PHPUnit by remote interpreter'. The remote interpreter is our DDev environment.
- 'PHP interpreter' should be DDev.
- 'Path mappings' should be set up by the DDev integration plugin.
- Under 'PHPUnit Library', select 'Path to phpunit.phar' and use the path `vendor/phpunit/phpunit/phpunit`
- Click the reload icon next to the path and see if PHPStorm finds the binary. If it doesn't maybe you haven't run `ddev composer install` yet?
- Leave the default configuration and bootstrap file fields empty.
- Click 'Apply' and 'OK'.

## 3. Set up a Run/Debug test runner

This is the 'script' you want to run the tests. The secret sauce to making this
easy to set up is that our phpunit.xml file contains as much of the configuration as possible.

- From the menu, select Run -> Edit Configurations...
- Click +.
- Select 'PHPUnit' as the basis of our runner.
- Give it a good name. I decided on 'DDev PHPUnit', because I lack creativity.
- Under 'Test runner', choose 'Defined in the configuration file'.
- Check the 'Use alternative configuration file' box, and enter the path to the configuration file. On my Mac, it looks like this: `/Users/[name]/projects/dkan-core/docroot/modules/contrib/dkan/phpunit.xml`. Yours might differ.
- For the preferred coverage engine, choose XDebug. Who knows, you might even generate a coverage report someday.
- 'Interpreter' should be DDEV.
- 'Custom working directory' should be the location of your DKAN module. Similar to the configuration file above: `/Users/[name]/projects/dkan-core/docroot/modules/contrib/dkan`.

This is the end of the easy part. Now comes the two complicated things:

### A) Environment variables

In order for the PHPStorm-based test to access our database and see our site, we have to
send in some environmental variables. These can be a pain to discover, and they
differ for every site. Therefore, we've added a DDev command for it:

    ddev dkan-get-env-for-phpunit

This command will output something like this:

    DRUPAL_ROOT=/var/www/html/docroot
    SIMPLETEST_BASE_URL=https://dkan-core.ddev.site
    SIMPLETEST_DB=mysql://db:db@dkan-core-db:3306/db
    PATH=~/bin:~/bin:/usr/local/sbin:[ ... ]

These are the three environmental variables you need in order to run Drupal PHPUnit tests, plus adding Drush to the path.

On a Mac you can pipe this into the copy/paste:

    ddev dkan-get-env-for-phpunit | pbcopy

Now head back to the test runner configuration and paste that in for environmental variables.

### B) Create fixture users using external tools

If you jumped the gun and clicked 'Apply' and 'OK' at this point, and tried to run the tests, you might have some success
with the runner. However, you'd see a lot of test fails.

That's because for DKAN, we must create users on the Drupal site. The DKAN addon allows for this with this command:

    ddev dkan-test-users

Now we can fill out the 'Before launch' part of the Run/Debug configuration.

- Click + in the 'Before launch' section.
- Choose 'Run External Tool'. This will show you another list.
- Click +.
- You can give your new external tool a name and description. I decided on 'create users'.
- 'Program' is the path to DDev. In my case, it's `/usr/local/bin/ddev`. If you want to find yours, you can say `which ddev` at the command line.
- 'Arguments' is the DDev command we want to run. Enter `dkan-test-users`.
- 'Working directory' should be `$ProjectFileDir$`.
- Click 'OK' and 'OK' again on the external tools window.
- Now you can 'Apply' and 'OK' on the Run/Debug configuration form.

## 4. Let's run the tests

- Ensure the Run/Debug dropdown has the config you just created.
- Click the little green play button next to it.
- You should see the script that creates users, and then the tests should start running.

Eventually the tests will finish and you'll know if they are passing.

Congratulations, you have configured the IDE to run the tests.

## 5. Let's debug the tests

- Tell DDev to use XDebug: `ddev xdebug on`.
- Tell PHPStorm to listen for XDebug by clicking on the little phone icon.
- Set a breakpoint in a test.
- Instead of clicking the green play button, click the green bug button.

The IDE might have stopped at the first line of PHPUnit. You can tell it to run again in the debug pane, but you can
also turn off this behavior in preferences under PHP -> Debug.

Congratulations. You have configured the IDE to do step debugging.
