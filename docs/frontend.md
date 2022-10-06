# Frontend Application Management

DKAN includes a front-end application to display and query data.

This front end can be managed using the following tools:

    ddev dkan-frontend-install
    ddev dkan-frontend-build

Note that in order to install the frontend, you must have previously run:

    ddev dkan-init
    ddev dkan-site-install

When it comes time for testing:

    ddev dkan-frontend-test

The dkan-frontend-test is intended for CI processes. Users are encouraged to
use local Cypress tooling for testing locally. This is due to an outstanding
issue with Cypress not running well on M1 Macs.
See: https://github.com/cypress-io/cypress-docker-images/issues/431

TODO: Document the frontend app discovery process.
