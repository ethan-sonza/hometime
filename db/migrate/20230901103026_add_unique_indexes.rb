class AddUniqueIndexes < ActiveRecord::Migration[7.0]
  def change
    add_index :guests, :email, unique: true
    add_index :reservations, :reservation_code, unique: true
  end
end
