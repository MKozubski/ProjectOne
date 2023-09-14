require 'httparty'

namespace :seed do
  desc "Seed dog breed images"
  task breed_images: :environment do
    fetch_and_seed_breed_images
  end

  def fetch_and_seed_breed_images
    Breed.all.each do |breed|
      response = HTTParty.get("https://dog.ceo/api/breed/#{breed.name}/images")
      urls = response.parsed_response["message"]

      urls.each do |url|
        breed.breed_images.create(url: url)
      end
    end
  end
end
