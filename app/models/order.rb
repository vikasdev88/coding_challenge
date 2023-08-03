class Order < ApplicationRecord
  validates :customer_name, :item, :pick_up_at, presence: true

  scope :sorted, ->(sort_column, sort_direction) { order("#{sort_column} #{sort_direction}") }
end
