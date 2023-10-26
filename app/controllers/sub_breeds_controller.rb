class SubBreedsController < ApplicationController
  def show
    @sub_breed = SubBreed.find(params[:id])
    @breed = @sub_breed.breed
  end
end
