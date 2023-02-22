# WorkflowsApiClient

## Summary
Create the necessary interface to interact with API Workflows, it will only
be necessary to configure and define where the routes will be created
(optional). Authentication methods can be defined for services as needed.

## Installation

Add gem 'workflows_api_client' to your gemfile

`Run rails g workflows_api_client:install`

Install with bundler `bundle install`

## Usage and Configuration

In the `initializer` file of the gem we can configure the gem. There you will find an extensive explanation of each of the possible configurations.

``` ruby
WorkflowsApiClient.configure do |config|
  # config.workflows_api_url It is required and should be the API Workflows url depending on the
  # environment you wish to configure. If it is not present an error will be thrown.
  config.workflows_api_url = ''

  # config.consumer_api_key It is required and must be the api_key of the 'Consumer' created in API
  # Workflows according to the environment you want to configure. If it is not present an error
  # will be thrown.
  config.consumer_api_key = ''

  # config.consumer_api_secret It is required and must be the 'api_secret' of the 'Consumer'
  # created in API Workflows according to the environment you want to configure. If it is not
  # present an error will be thrown.
  config.consumer_api_secret = ''

  # config.async_request_helper Required, shall be the helper class that is included in
  # the controllers to make asynchronous calls to API Workflows 'AsyncRequest::ApplicationHelper'
  config.async_request_helper = 'AsyncRequest::ApplicationHelper'

  # config.controller_to_inherit_authentication  Is optional, it shall be the class of the
  # controller that has the desired authentication method for the services generated by the
  # gem. By default it will be the 'ApplicationController' of the gem.
  config.controller_to_inherit_authentication = 'ApplicationController'

  # config.services_namespace This is optional, it defaults to 'workflows' and defines the prefix
  # of the paths that the gem will generate. For example the default path will be set to
  # '/workflows/test'. It can be null and have no prefix '/test'.
  config.services_namespace = 'workflows'

  # config.define_routes_manually Is required, defaults to false and defines whether routes will
  # be placed manually or by default by the gem. If manual placement is desired (true), it will be
  # necessary to mount the gem engine under the desired namespace to generate the routes.
  # Including the following statement in the routes.rb file should be sufficient:
  # rubocop:disable Layout/LineLength
  # mount WorkflowsApiClient::Engine, at: "/#{WorkflowsApiClient.config[:services_namespace]}", as: 'workflows_api_client'.
  # rubocop:enable Layout/LineLength
  config.define_routes_manually = false
end
```
The same explanation but prettier:

`config.workflows_api_url` It is required and should be the API Workflows url depending on the environment you wish to configure. If it is not present an error will be thrown.

`config.consumer_api_key` It is required and must be the api_key of the 'Consumer' created in API Workflows according to the environment you want to configure. If it is not present an error will be thrown.

`config.consumer_api_secret` It is required and must be the 'api_secret' of the 'Consumer' created in API Workflows according to the environment you want to configure. If it is not present an error will be thrown.

`config.async_request_helper` Required, shall be the helper class that is included in the controllers to make asynchronous calls to API Workflows `AsyncRequest::ApplicationHelper`

`config.controller_to_inherit_authentication` Is optional, it shall be the class of the controller that has the desired authentication method for the services generated by the gem. By default it will be the `ApplicationController` of the gem.

`config.services_namespace` This is optional, it defaults to `'workflows'` and defines the prefix of the paths that the gem will generate. For example the default path will be set to `'/workflows/test'`. It can be null and have no prefix `'/test'`.

`config.define_routes_manually` Is required, defaults to false and defines whether routes will be placed manually or by default by the gem. If manual placement is desired (true), it will be necessary to mount the gem engine under the desired namespace to generate the routes. Including the following statement in the routes.rb file should be sufficient:

`mount WorkflowsApiClient::Engine, at: "/#{WorkflowsApiClient.config[:services_namespace]}", as: 'workflows_api_client'`.

## Methods
All methods will receive as first parameter the `utility_id` value corresponding to the unique code for the utility in UGO.
### Workflows
#### Index

* Method call:
``` ruby
WorkflowsApiClient.workflows_index(utility_id)
```

#### Show:

* Params:
  * `code` It is the unique code of the workflow

* Method call:
``` ruby
WorkflowsApiClient.workflows_show(utility_id, code)
```
### Workflow Responses

#### Index:

* Params:
  * `filters` It is a hash that supports the filters for the index. For example:
  ``` ruby
    {
      user_external_id: 2,
      account_external_id: 10500
    }
   ```
* Method call:
``` ruby
WorkflowsApiClient.workflow_responses_index(utility_id, filters)
```

#### Show:

* Params:
  * `id` It is the unique id of the workflow response
* Method call:
``` ruby
WorkflowsApiClient.workflow_responses_show(utility_id, id)
```

#### Create:

* Params:
  * `workflow_code` It is the unique code of the workflow
  * `input_values` It is a hash containing the input_values of the workflow step, for example:
    ``` ruby
    {
      key: 'value'
    }
    ```
  * `external_params` These are the extra and optional parameters supported by the creation of a      workflow response. At the moment they will be `user_external_id` and `account_external_id`.
  
    Method call example:
    ``` ruby
      WorkflowsApiClient.workflow_responses_create(utility_id, workflow_code, input_values, user_external_id, account_external_id)
    ```
* Method call code:
``` ruby
WorkflowsApiClient.workflow_responses_create(utility_id, workflow_code, input_values, *external_params)
```

#### Update:

* Params:
  * `workflow_response_id` It is the unique id of the workflow response
  * `input_values` It is a hash containing the input_values of the workflow step, for example:
    ``` ruby
    {
      key: 'value'
    }
    ```
* Method call:
``` ruby
WorkflowsApiClient.workflow_responses_update(utility_id, workflow_response_id, input_values)
```

#### Destroy:

* Params:
  * `workflow_response_id` It is the unique id of the workflow response
* Method call:
``` ruby
WorkflowsApiClient.workflow_responses_destroy(utility_id, workflow_response_id)
```

## Development

To use the gem locally we have to make some configurations. Especially to be able to run the tests correctly.

### 1- Installing basic dependencies:

  - If you are using Ubuntu:

  ```bash
    sudo apt update
    sudo apt install build-essential libpq-dev nodejs libssl-dev libreadline-dev zlib1g-dev redis-server
  ```

  - If you are using MacOS:

  ```bash
    brew install postgresql
    brew install redis
  ```

### 2- Installing Ruby

- Clone the repository by running `git clone https://github.com/widergy/Workflows-API-Client.git`
- Go to the project root by running `cd Workflows-API-Client`
- Download and install [Rbenv](https://github.com/rbenv/rbenv#basic-github-checkout). Read the [How rbenv hooks into your shell](https://github.com/rbenv/rbenv#how-rbenv-hooks-into-your-shell) section and the `rbenv init - ` output carefully. You may need to do step 1 of that section manually.
- Download and install [Ruby-Build](https://github.com/rbenv/ruby-build#installing-as-an-rbenv-plugin-recommended).
- Install the appropriate Ruby version by running `rbenv install [version]` where `version` is the one located in [.ruby-version](.ruby-version)

### 3- Installing Rails gems

- Install [Bundler](http://bundler.io/).

```bash
  gem install bundler --no-document
  rbenv rehash
```
- Install all the gems included in the project.

```bash
  bin/setup
```

### 4- Database Setup

- Install postgres in your local machine:

  - If you are using Ubuntu:

  ```bash
    sudo apt install postgresql
  ```

  - If you are using MacOS: install [Postgres.app](https://postgresapp.com/)

- Create the development database:

  - If you are using Ubuntu:

    Run in terminal:

    ```bash
      sudo -u postgres psql
      CREATE ROLE "dummy" LOGIN CREATEDB PASSWORD 'dummy';
    ```

  - If you are using MacOS:

    Open the Postgres app and run in that terminal:

    ```bash
      CREATE ROLE "dummy" LOGIN CREATEDB PASSWORD 'dummy';
    ```

- Log out from postgres

- Check if you have to get a `.env` file, and if you have to, copy it to the root.

- Run in terminal:

```bash
  spec/dummy/bin/rails db:create
```

### 5- Gem Setup

Your gem is ready to run. You can run `bin/console` for an interactive prompt that will allow you to experiment.

To install the gem locally in another project, add this line to the Gemfile:
`gem 'hello_world', path: '{PATH TO THE LOCAL GEM REPOSITORY}'` for example (`'../Workflows-API-Client'`)

#### Running tests & linters

- For running the test suite:

```bash
  bundle exec rspec
```

- For running code style analyzer:

```bash
  bundle exec rubocop
```

## About

This project is written by [Widergy](http://www.widergy.com).

[![W-logotipo-RGBsinfondo.png](https://i.postimg.cc/Vsg8YBwL/W-logotipo-RGBsinfondo.png)](https://postimg.cc/G94NKD9Z)
