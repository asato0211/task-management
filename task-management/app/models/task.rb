class Task < ApplicationRecord
  validates :title, presence: true , length: { maximum: 70 }
end
