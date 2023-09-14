def index
  @breed_image = random_breed_image
  render :index
end

def random
  @breed_image = random_breed_image
  render :index
end

private

def random_breed_image
  BreedImage.order(Arel.sql('RANDOM()')).first
end
