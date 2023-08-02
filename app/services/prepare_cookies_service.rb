class PrepareCookiesService < ApplicationService
  attr_reader :oven, :quantity, :fillings

  def initialize(oven, quantity, fillings)
    @oven = oven
    @quantity = quantity
    @fillings = fillings
  end

  def call
    create_cookies
    CookiePreparationJob.set(wait: Settings.cookie_preparation_job_delay).perform_later(oven.id)
  end

  private

  def create_cookies
    cookies_record = [{ fillings: }] * quantity
    oven.cookies.insert_all!(cookies_record)
  end
end
