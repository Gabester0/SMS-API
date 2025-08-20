ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "minitest/autorun"
require 'devise'

class MongoidTestCase < Minitest::Test
  def setup
    # Clean the database before each test
    Mongoid.default_client.collections.each do |collection|
      collection.delete_many unless collection.name.include?('system')
    end
  end

  def teardown
    # Clean up after each test
    Mongoid.default_client.collections.each do |collection|
      collection.delete_many unless collection.name.include?('system')
    end
  end

  # Add assertion methods from ActiveSupport::TestCase
  def assert_includes(collection, obj, msg = nil)
    msg = message(msg) { "Expected #{collection.inspect} to include #{obj.inspect}" }
    assert_respond_to collection, :include?
    assert collection.include?(obj), msg
  end

  def refute(test, msg = nil)
    msg = message(msg) { "Expected #{test.inspect} to be false/nil" }
    assert !test, msg
  end
end
