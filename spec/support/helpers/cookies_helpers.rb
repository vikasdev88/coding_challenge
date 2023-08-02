module CookiesHelpers
  def wait_for_cookies_to_be_ready(oven)
    while oven.cookies.cooking.present?
      puts "Waiting for the cookies to be ready..."
      sleep 0.5
      oven.reload
    end
  end
end
