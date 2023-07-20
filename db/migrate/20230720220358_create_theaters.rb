class CreateTheaters < ActiveRecord::Migration[7.0]
  def change
    create_table :theaters do |t|
      t.integer :number_of_seats
      t.float :turnover_time
      t.integer :reservations_count

      t.timestamps
    end
  end
end
