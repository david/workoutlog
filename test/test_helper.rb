ENV["RAILS_ENV"] ||= "test"

require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    def sign_in_as(user)
      get create_session_url(token: user.generate_token_for(:authentication))
    end
  end
end
