class HierarchicalSearchController < ApplicationController
    def search
      sub_breeds_count = params[:sub_breeds_count].to_i
      @search_performed = true
      @breeds = Breed.includes(:sub_breeds).select { |breed| breed.sub_breeds.count == sub_breeds_count }
      @breeds_count = sub_breeds_count
    end
  end
  