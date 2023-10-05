class Breed < ApplicationRecord
  has_many :sub_breeds, dependent: :destroy
  has_many :breed_images
  validates :name, presence: true, uniqueness: true,  length: { in: 3..15 }
end