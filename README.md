# Introduction
What ftts-test-data-manager is
This manages the test data for the performance testing environment 

It currently has the following endpoints

POST /provision

POST /reserve

POST /retrieve

Purpose of ftts-test-data-manager
This be used to manage the test data for the performance testing environment

# Installation
1) Install azure-functions-core-tools using homebrew

`brew tap azure/functions`

`brew install azure-functions-core-tools@4`

Note before installing make sure nvm is version 7 or greater to ensure peer dependencies install

Check by running  `nvm --version` and update with `npm install -g npm@7.9.0`

2. Install:

`npm i`
# Build, Run and Test

Build:

`npm run build`

Run:

`npm run func:start`

To run the unit tests:

`npm run test`
