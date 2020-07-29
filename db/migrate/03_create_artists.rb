class CreateArtists < ActiveRecord::Migration[6.0]
  def change
      create_table :artists do |t|
        t.string :name
        t.string :genre
         end
    end
  end

  Artist.create(name: "Drake", genre: "Rap")
  Artist.create(name: "Red Hot Chili Peppers", genre: "Rock")
  Artist.create(name: "Taylor Swift", genre: "Pop")
  Artist.create(name: "Bob Marley", genre: "Reggae")
  Artist.create(name: "Snoop Dog", genre: "Rap")
  