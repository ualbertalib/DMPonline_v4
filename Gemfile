source 'https://rubygems.org'

gem 'rails', '~>3.2.22'

# pin this to post-CVE 2017-5946
gem 'rubyzip', '~> 1.2.1'

gem 'mysql2', '~>0.3.20'
gem 'omniauth'
gem 'omniauth-shibboleth'
gem 'recaptcha'
gem 'i18n'
gem 'globalize', '~>3.1.0'
gem 'dragonfly'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails', '~> 3.2.1'
end

group :development do
  gem "better_errors"
  gem "binding_of_caller"
end

gem 'uglifier'
gem 'less-rails'

gem 'twitter-bootstrap-rails', '~> 2.2.8'
gem 'sass-rails',   '~> 3.2.3'
gem 'sass'

gem 'jquery-rails'
#gem 'jquery-ui-rails'

gem 'tinymce-rails'
gem 'friendly_id'
gem 'contact_us'

#implementation of forms
gem 'activeadmin', '1.0.0.pre1'

#to allow cloning of objects
gem 'amoeba'

# devise for user authentication
gem 'devise'
gem 'devise_invitable'

#cancan for usergroups
gem 'cancan'

#to notify admin of errors
gem 'exception_notification'

#rolify for roles
gem 'rolify'
# Gems for repository integration
gem 'email_validator'
gem 'validate_url'
# gem 'sword2ruby'

gem 'thin'
gem 'wicked_pdf'
gem 'htmltoword'
# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

group :development, :test do
  gem 'rspec-rails'
  gem 'rspec'
  gem 'selenium-webdriver'
  gem 'mail', '~> 2.5.5'
  gem 'pdf-reader'
  gem 'nokogiri', '~> 1.7.2'
end

group :production do
  gem 'therubyracer', '0.11.4', platforms: :ruby
  gem 'libv8'
end

group :test, :production do
  gem 'syslog-logger'
end

group :ci do
  gem 'ci_reporter', '1.9.2'
end

gem 'ledermann-rails-settings'
gem 'jbuilder'
