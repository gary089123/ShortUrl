class CreateUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :urls do |t|
      t.string :origin
      t.string :redirect

      t.timestamps
    end
  end
end
