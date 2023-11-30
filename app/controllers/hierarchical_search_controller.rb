class HierarchicalSearchController < ApplicationController
  def search
    # Convert the sub_breeds_count parameter to an integer.
    sub_breeds_count = params[:sub_breeds_count].to_i
    # Flag to indicate that a search was performed, used in the view.
    @search_performed = true

    # Check if the provided sub_breeds_count is a positive number.
    if sub_breeds_count.positive?
      # Efficient database query to find breeds with the exact number of sub-breeds.
      # The query offloads the work of filtering to the database instead of Ruby's select method,
      # which is more efficient and reduces memory usage.
      @breeds = Breed.joins(:sub_breeds).group('breeds.id').having('COUNT(sub_breeds.id) = ?', sub_breeds_count)
    else
      # If the count is invalid (not positive), set breeds to an empty array
      # and use flash.now to display an error message on the same page.
      # This approach avoids unnecessary redirection and enhances user experience.
      @breeds = []
      flash.now[:alert] = 'Invalid sub breeds count'
    end

    # Store the count of sub-breeds for use in the view.
    @breeds_count = sub_breeds_count
  end
end
