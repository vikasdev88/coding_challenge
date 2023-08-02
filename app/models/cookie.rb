class Cookie < ActiveRecord::Base
  belongs_to :storage, polymorphic: :true

  validates :storage, :status, presence: true

  enum status: { cooking: 0, ready: 1 }
end
