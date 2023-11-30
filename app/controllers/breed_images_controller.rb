class BreedImagesController < ApplicationController
  # Constants for configurable values
  MIN_BREED_NAME_LENGTH = 3
  MAX_BREED_NAME_LENGTH = 25
  IMAGES_PER_PAGE = 10

  # Action to display a random breed image
  def index
    load_random_breed_image
    render :index
  end

  # Action to display a random breed image (same as index)
  def random
    load_random_breed_image
    render :index
  end

  # Action to search for a breed by name
  def search
    if params[:breed_name].present?
      breed_name = params[:breed_name].downcase
      if breed_name.length.between?(MIN_BREED_NAME_LENGTH, MAX_BREED_NAME_LENGTH)
        @breed = find_breed_by_name(breed_name)

        if @breed
          @breed_images = @breed.breed_images.page(params[:page]).per(IMAGES_PER_PAGE)
        else
          handle_breed_not_found
        end
      else
        handle_invalid_breed_name_length
      end
    else
      handle_no_breed_name_provided
    end
  end

  # Action to display a specific breed image
  def show
    @breed_image = BreedImage.find(params[:id])
    @breed = @breed_image.breed
  end

  private

  # Helper method to load a random breed image
  def load_random_breed_image
    @breed_image = random_breed_image
  end

  # Helper method to retrieve a random breed image from the database
  def random_breed_image
    BreedImage.order(Arel.sql('RANDOM()')).first
  end

  # Helper method to find a breed by its name
  def find_breed_by_name(name)
    Breed.where('name LIKE ?', "%#{name}%").first
  end

  # Helper method to handle the case when the breed is not found
  def handle_breed_not_found
    flash.now[:error] = "Breed not found."
    @breed_images = []
  end

  # Helper method to handle the case when the breed name length is invalid
  def handle_invalid_breed_name_length
    flash.now[:error] = "Breed name should be between #{MIN_BREED_NAME_LENGTH} and #{MAX_BREED_NAME_LENGTH} characters."
    @breed_images = []
  end

  # Helper method to handle the case when no breed name is provided
  def handle_no_breed_name_provided
    flash.now[:error] = "Please enter a breed name."
    @breed_images = []
  end
end
