source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.2'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Track app with New Relic
gem 'newrelic_rpm'
# Use Figaro to manage Environment variables
gem 'figaro'
# Track app exceptions with Sentry.io
gem "sentry-raven"
# Use react_on_rails to manage React.js integration
gem 'react_on_rails', '~> 6'
# Use acts_as_tenant to handle multi-tenancy scoping for Models
gem 'acts_as_tenant', '~> 0.3.9'
# Use devise gem for User authentication
gem 'devise', '~> 4.2'
# User device_invitable for User invitations
gem 'devise_invitable', '~> 1.7.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # View sent emails with letter_opener_web
  gem 'letter_opener_web'
end

group :development, :test do
  # Use rspec for testing framework
  gem 'rspec-rails', '~> 3.5'
  # Include helpers for controller tests
  gem 'rails-controller-testing'
  # Include mock_model helper for mocking Models in specs
  gem 'rspec-activemodel-mocks'
  # Use Should Matchers gem to help with model specs
  gem 'shoulda-matchers', '~> 3.1'
  # Use Capybara for acceptance testing
  gem 'capybara'
  #  user capybara-email for testing emails in feature specs
  gem 'capybara-email', '~> 2.5'
  # Use Poltergeist Webdriver for js dependent feature tests
  gem 'poltergeist'
  # Use Launchy to open pages in feature specs
  gem 'launchy'
end

# Test for Code Coverage with SimpleCov
gem 'simplecov', :require => false, :group => :test

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'mini_racer', platforms: :ruby
