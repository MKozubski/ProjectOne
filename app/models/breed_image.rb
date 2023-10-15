class BreedImage < ApplicationRecord
  belongs_to :breed
  validates :breed_name, presence: true, length: { in: 3..15 }
end
