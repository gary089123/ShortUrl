class CreateClicks < ActiveRecord::Migration[5.1]
  def change
    create_table :clicks do |t|
      t.timestamp :time
      t.string :referrer
      t.string :browser
      t.string :country
      t.string :platform
      t.integer :url_id ,:index =>true

      t.timestamps
    end
  end
end
