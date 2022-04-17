source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'rails', '~> 6.1.5'
gem 'pg', '~> 1.3.5'
gem 'puma', '~>5.6.4'
# Use SCSS for stylesheets
gem 'sass-rails', '~>6.0.0'
# https://github.com/rails/webpacker
gem 'webpacker', '~>5.4.3'
# https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~>5.2.1'
# https://github.com/rails/jbuilder
gem 'jbuilder', '~>2.11.5'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

gem 'bootsnap', '~>1.11.1'

gem 'rails-i18n', '~>6.0.0'
gem 'nokogiri', '~>1.13.4'

gem 'dotenv-rails', '~>2.7.6'

gem 'devise', '~>4.8.1'

gem 'net-smtp', '~>0.3.1'
gem 'net-pop', '~>0.1.1'
gem 'net-imap', '~>0.2.3'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console'
  # https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler'
  gem 'listen'
  gem 'spring'
  gem 'bullet'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'rexml'
end
