source 'https://rubygems.org'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'
gem 'bootstrap-validator-rails'
# Use pg as the database for Active Record
gem 'pg'
gem 'pg_search'
gem 'friendly_id', '~> 5.1.0'
# Transliterate cyrillic
gem 'babosa'
# Very simple Roles library
gem 'rolify'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Refactor application
gem 'rename'
# RailsAdmin is provides an easy-to-use interface for managing your data
gem 'remotipart', github: 'mshibuya/remotipart'
gem 'rails_admin', '>= 1.0.0.rc'
# CKEditor is a WYSIWYG text editor designed to simplify web content creation
gem 'ckeditor', github: 'galetahub/ckeditor'
# Paperclip is intended as an easy file attachment library for ActiveRecord.
gem 'Bootstrap-Image-Gallery-rails'
gem 'paperclip', git: 'git://github.com/thoughtbot/paperclip.git'
gem 'dropzonejs-rails'
# Devise is a flexible authentication solution for Rails based on Warden
gem 'devise'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
# Awesome Nested Set is an implementation of the nested set pattern for AR
gem 'awesome_nested_set'
# Use Bootstrap for UI CSS
gem 'bootstrap-sass'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Use jquery-inputmask for fields
gem 'jquery-inputmask-rails'
# Use phony_rails for managment pnone_numbers
gem 'phony_rails'
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

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'guard'
  gem 'guard-rails'
end

group :test do
  gem 'database_cleaner'
  gem 'guard-rspec', require: false
  gem 'rspec-rails', '~> 3.5'
  gem 'shoulda-matchers', '~> 3.1'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '~> 3.0.5'
  gem 'web-console'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'capistrano', '~> 3.6'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-rvm'
  gem 'capistrano3-puma'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
