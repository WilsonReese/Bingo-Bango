class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.integer :user_id
      t.integer :theater_id
      t.string :status, default: "pending"
      t.datetime :start_time
      t.datetime :end_time
      t.float :duration
      t.integer :number_guests
      t.string :content_choice

      t.timestamps
    end
  end
end
