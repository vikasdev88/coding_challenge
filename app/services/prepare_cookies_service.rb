class PrepareCookiesService < ApplicationService
  attr_reader :oven, :quantity, :fillings

  def initialize(oven, quantity, fillings)
    @oven = oven
    @quantity = quantity
    @fillings = fillings
  end

  def call
    create_cookies
  end

  private

  def create_cookies
    cookies_record = [{ fillings: fillings }] * quantity
    oven.cookies.insert_all!(cookies_record)
  end
end
