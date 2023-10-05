class BreedsController < ApplicationController
  def index
    @breeds = Breed.includes(:sub_breeds).page(params[:page]).per(10)
  end

  def search
    @breed = nil
    flash.now[:error] = nil
  
    if params[:breed_name].present?
      search_term = params[:breed_name].downcase
      if search_term.length < 3 || search_term.length > 15
        flash.now[:error] = "Breed name must be between 3 and 15 characters"
      else
        @breed = Breed.includes(:sub_breeds, :breed_images).find_by('name LIKE ?', "%#{search_term}%")
        @sub_breeds = @breed&.sub_breeds
        @random_image = @breed&.breed_images&.order(Arel.sql('RANDOM()'))&.first
  
        if @breed.nil?
          flash.now[:error] = "Breed not found"
        end
      end
    else
      flash.now[:error] = "Please enter a breed name" # Set the error message for empty search
    end
  
    render :search
  end
  
end  