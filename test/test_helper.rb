ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/autorun"

# Configure Mongoid for testing
Mongoid.load!(Rails.root.join("config/mongoid.yml"), :test)

class MongoidTestCase < Minitest::Test
  def setup
    Mongoid.default_client.collections.each do |collection|
      collection.delete_many unless collection.name.include?('system')
    end
  end
end
