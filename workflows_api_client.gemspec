require_relative 'lib/workflows_api_client/version'

Gem::Specification.new do |spec|
  spec.name = 'workflows_api_client'
  spec.version = WorkflowsApiClient::VERSION
  spec.authors = ['Widergy']
  spec.email = ['PENDING']

  spec.summary = 'Create the necessary interface to interact with API Workflows'
  spec.description = 'Create the necessary interface to interact with API Workflows, it will only
                      be necessary to configure and define where the routes will be created
                      (optional). Authentication methods can be defined for services as needed.'
  spec.homepage = 'https://github.com/widergy/Workflows-API-Client'
  spec.required_ruby_version = '>= 2.7'

  spec.files = Dir['{app,config,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  spec.test_files = Dir['spec/**/*']

  # Rails
  spec.add_dependency 'rails', '< 6'

  # Sidekiq
  spec.add_dependency 'sidekiq', '< 7'

  # Awesome Print is a Ruby library that pretty prints Ruby objects in full color exposing their
  # internal structure with proper indentation
  spec.add_development_dependency 'awesome_print'

  # Better Errors replaces the standard Rails error page with a much better and more useful
  # error page.
  spec.add_development_dependency 'better_errors'

  # Debugger
  spec.add_development_dependency 'byebug'

  # Factory
  spec.add_development_dependency 'faker'

  # Use postgresql as the database for Active Record
  spec.add_development_dependency 'pg', '>= 0.18', '< 1.3.0'

  # Helper
  spec.add_development_dependency 'rails_best_practices'

  # Use for sending request to 3rd party APIs
  spec.add_development_dependency 'httparty', '~> 0.17'

  # RSpec testing framework for Ruby on Rails as a drop-in alternative to its default testing
  # framework, Minitest.
  spec.add_development_dependency 'rspec-rails', '~> 3.8'

  # Code style
  spec.add_development_dependency 'rubocop', '~> 0.88'
  spec.add_development_dependency 'rubocop-rails'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.32.0'

  # Helper
  spec.add_development_dependency 'rubycritic'

  # Rspec helpers
  spec.add_development_dependency 'shoulda-matchers', '~> 4.0'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'test-prof'
  spec.add_development_dependency 'vcr', '~> 4.0'
  spec.add_development_dependency 'webmock'
end
