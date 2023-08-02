require 'support/helpers/session_helpers'
require 'support/helpers/request_helpers'
require 'support/helpers/cookies_helpers'

RSpec.configure do |config|
  config.include Features::SessionHelpers, type: :feature
  config.include RequestHelpers, type: :request
  config.include CookiesHelpers
end
