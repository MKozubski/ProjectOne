require 'httparty'

# API endpoint
url = "https://dog.ceo/api/breeds/list/all"

# Fetch the data
response = HTTParty.get(url)

if response.code == 200 && response['status'] == 'success'
  breeds_data = response['message']

  breeds_data.each do |breed_name, sub_breeds|
    breed = Breed.create!(name: breed_name)

    sub_breeds.each do |sub_breed_name|
      SubBreed.create!(name: sub_breed_name, breed: breed)
    end
  end

  puts "Successfully populated the database with breeds and sub-breeds."
else
  puts "Failed to fetch data from the Dog API. HTTP Status: #{response.code}"
end
