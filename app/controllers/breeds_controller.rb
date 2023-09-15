class BreedsController < ApplicationController
  def index
    @breeds = Breed.includes(:sub_breeds).page(params[:page]).per(10)
  end
end
