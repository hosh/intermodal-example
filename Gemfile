source 'http://rubygems.org'

# See Pull Request https://github.com/rails/rails/pull/3243
# QueryCache/ConnectionPool thread fix (was #1670)
#gem 'activerecord', :path => 'vendor/rails/activerecord'

gem 'rails', '3.1.1'
gem 'intermodal', :path => 'vendor/gems/intermodal'
gem 'warden'
gem 'redis'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'pg'
gem 'yajl-ruby'
gem 'rake'

# Console convenience
group :development do
  gem 'awesome_print', :require => 'ap'
  gem 'pry'
end

group :development, :test do
  gem 'rspec-rails', '~> 2.6'
end

# Bundle gems for certain environments:
group :test do
   gem 'database_cleaner'
   gem 'remarkable', '>=4.0.0.alpha4'
   gem 'remarkable_activemodel', '>=4.0.0.alpha4'
   gem 'remarkable_activerecord', '>=4.0.0.alpha4'
   gem 'machinist', '>=2.0.0.beta2'
   gem 'forgery'
end

