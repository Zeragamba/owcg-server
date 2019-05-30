# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

JWT_SECRET = ENV["AUTH_TOKEN_SECRET"]
JWT_ALGORITHM = "HS512"