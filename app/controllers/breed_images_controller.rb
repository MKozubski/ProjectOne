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
      breed_name = params[:breed_name].downcase
      @breed = Breed.find_by('name LIKE ?', "%#{breed_name}%")

      if @breed
        @breed_images = @breed.breed_images.page(params[:page]).per(10)
      else
        flash.now[:error] = "Breed not found."
        @breed_images = BreedImage.none
      end
    else
      flash.now[:error] = "Please enter a breed name."
      @breed_images = BreedImage.none
    end
  end

  private

  def random_breed_image
    BreedImage.order(Arel.sql('RANDOM()')).first
  end
end
