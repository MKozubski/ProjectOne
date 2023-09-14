require 'httparty'

namespace :seed do
  desc 'Seed breed images from the API'
  task breed_images: :environment do
    puts "Starting to seed breed images..."

    Breed.all.each do |breed|
      response = HTTParty.get("https://dog.ceo/api/breed/#{breed.name}/images")
      image_urls = response['message']

      image_urls.each do |url|
        BreedImage.create!(url: url, breed_id: breed.id)
      end
    end

    puts "Finished seeding breed images!"
  end
end
