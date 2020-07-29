
class CreateUsers < ActiveRecord::Migration[6.0]
  def change
      create_table :users do |t|
        t.string :name
        t.string :genre
        t.string :location
        end
    end
  end
   

  User.create(name: "Martin", genre:"Rock", location: "Houston" )
  User.create(name:"Chris", genre: "Rock", location: "San Antonio" )
  User.create(name: "Charlie", genre: "Reggae", location: "Austin")