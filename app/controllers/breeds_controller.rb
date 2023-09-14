class BreedsController < ApplicationController
  def index
    @breeds = Breed.includes(:sub_breeds).all
  end
end
