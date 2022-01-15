# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in protocol-http.gemspec
gemspec

group :maintenance, optional: true do
	gem "bake-modernize"
	gem "bake-gem"
	
	gem "utopia-project"
end

group :test do
	gem 'async-io'
	gem 'async-rspec'
end
