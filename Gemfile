source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.2.3'
gem 'pg', '~>0.21'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby
gem 'exception_notification'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'redis', '~> 3.0'
gem 'devise'
gem 'simple_token_authentication'
gem 'pundit'
# gem 'bcrypt', '~> 3.1.7'
# for background processing
gem 'sinatra', require: false
gem 'sidekiq', '< 5' #breaking changes from 5.0 onwards
gem 'sidekiq-failures' # can now see failures tab in sidekiq ui
gem 'sidekiq-unique-jobs'
gem 'whenever', require: false

# connect to cache
gem 'readthis'
gem 'hiredis'

gem 'date_validator'
gem 'mini_magick'
gem 'image_processing'
gem 'fog', '~>1.3'

gem 'httparty', '0.14.0'
gem 'pdfkit'
gem 'rubyzip'
gem 'rack-cors'
gem 'active_model_serializers', '~> 0.10.0'
gem 'timecop'
gem 'kaminari'
gem 'friendly_id', '~> 5.2.4'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'pry'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rubocop'
  gem 'factory_bot_rails'
  gem 'pry-rails'
  gem 'pry-nav'
  gem 'rspec-rails', '~> 3.5.1'
  gem 'rspec-core', '~> 3.5.2'
  gem 'rspec-collection_matchers'
  gem 'shoulda-matchers', '~>3.1'
  gem 'shoulda-callback-matchers'
  gem 'thin'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
