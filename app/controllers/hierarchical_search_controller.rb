class HierarchicalSearchController < ApplicationController
  def search
    sub_breeds_count = params[:sub_breeds_count].to_i
    @search_performed = true

    if sub_breeds_count.positive?
      @breeds = Breed.joins(:sub_breeds).group('breeds.id').having('COUNT(sub_breeds.id) = ?', sub_breeds_count)
    else
      @breeds = []
      flash.now[:alert] = 'Invalid sub breeds count'
    end

    @breeds_count = sub_breeds_count
  end
end
