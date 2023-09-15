class BreedsController < ApplicationController
  def index
    @breeds = Breed.includes(:sub_breeds).page(params[:page]).per(10)
  end

  def search
    if params[:breed_name].present?
      @breed = Breed.includes(:sub_breeds, :breed_images).find_by('name LIKE ?', "%#{params[:breed_name].downcase}%")
      @sub_breeds = @breed&.sub_breeds
      @random_image = @breed&.breed_images&.order(Arel.sql('RANDOM()'))&.first
    end
  end
end
