class CreateBreedImages < ActiveRecord::Migration[7.0]
  def change
    create_table :breed_images do |t|
      t.string :url
      t.references :breed, null: false, foreign_key: true

      t.timestamps
    end
  end
end
