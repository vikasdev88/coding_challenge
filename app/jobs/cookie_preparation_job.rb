class CookiePreparationJob < ApplicationJob
  queue_as :default

  def perform(oven_id)
    oven = Oven.find(oven_id)
    oven.cookies.cooking.update_all(status: 'ready')
  end
end
