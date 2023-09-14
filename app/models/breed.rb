class Breed < ApplicationRecord
  has_many :sub_breeds, dependent: :destroy
  has_many :breed_images
end