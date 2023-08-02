class Oven < ActiveRecord::Base
  belongs_to :user
  has_many :cookies, class_name: 'Cookie', as: :storage, dependent: :destroy

  validates :user, presence: true

  def valid_cookie_quantity?(cookie_quantity)
    return false unless cookie_quantity.positive?

    cookie_quantity <= Settings.maximum_cookies_allowed_in_an_oven
  end
end
