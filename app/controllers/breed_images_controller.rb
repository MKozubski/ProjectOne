class BreedImagesController < ApplicationController
  def index
    @breed_image = random_breed_image
    render :index
  end

  def random
    @breed_image = random_breed_image
    render :index
  end

  def search
    if params[:breed_name].present?
      @breed = Breed.find_by('name LIKE ?', "%#{params[:breed_name].downcase}%")
      @breed_images = @breed.breed_images.page(params[:page]).per(10) if @breed
    else
      @breed_images = BreedImage.none
    end
  end

  private

  def random_breed_image
    BreedImage.order(Arel.sql('RANDOM()')).first
  end
end
