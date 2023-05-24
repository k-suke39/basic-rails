class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name,  presence: true, length: { maximum: 255 }
end
