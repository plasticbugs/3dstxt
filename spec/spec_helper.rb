# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require "factory_girl_rails"
require 'capybara/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  
  def test_sign_in(user)
    jar = ActionDispatch::Cookies::CookieJar.build(@request)
    jar.signed[:remember_token] = [user.id, user.salt]
    @request.cookies[:remember_token] = jar[:remember_token]
    
    controller.sign_in(user)
    
    current_user = user
    @current_user = user
  end
  
  def test_sign_out
    current_user = nil
    @current_user = nil
    @request.cookies.delete(:remember_token)
  end
  
  def test_signed_in?
    return !current_user.nil?
  end
  
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true
end
