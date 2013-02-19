source 'https://rubygems.org'

gem 'rails', '3.2.12'

gem 'sqlite3'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # If you haven't got node.js runtime installed, you need to un comment this.
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
	gem 'compass-rails'
end

group :development do
	# comment this if you are not on OSX.
	gem 'rb-fsevent', require: false
	
	gem 'guard'             # for easy development
	gem 'guard-livereload'
	gem 'guard-rspec'

	gem 'quiet_assets'      # goddamn webrick assets complains!

  gem 'better_errors'     # must to have
	gem 'binding_of_caller'
	gem 'meta_request'

	gem 'bullet'            # for N+1 and counter cache improvments
end

group :test do
	gem 'shoulda'
	gem 'shoulda-matchers'
	gem 'mocha'
	gem 'capybara'
	gem 'launchy'
end

group :development, :test do 
	gem 'rspec-rails'
	gem 'factory_girl_rails'
end

gem 'jquery-rails'

gem 'haml'
gem 'haml-rails'

gem 'devise'
