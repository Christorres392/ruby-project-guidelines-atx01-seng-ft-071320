class CreateEvent < ActiveRecord::Migration[6.0]
    def change
        create_table :events do |t|
          t.integer :rating
          t.string :comments
          t.string :venue
          t.date :event_date 
          end
      end
    end