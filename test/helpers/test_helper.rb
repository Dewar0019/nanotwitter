# test_helper.rb
ENV['RACK_ENV'] = 'test'

require_relative '../../app.rb' 

require 'rack/test'
require 'minitest'
require 'minitest/autorun' 
require 'capybara'
require 'capybara/dsl'

#def app() Sinatra::Base end

Capybara.app = eval("Rack::Builder.new {( " + File.read(File.dirname(__FILE__) + '/../../config.ru') + "\n )}")
Capybara.register_driver :rack_test do |app|
  Capybara::RackTest::Driver.new(app, :headers =>  { 'User-Agent' => 'Capybara' })
end