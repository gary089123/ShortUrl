class CreateTracks < ActiveRecord::Migration[5.1]
  def change
    create_table :tracks do |t|
      t.belongs_to :user, index: true
      t.belongs_to :url, index: true

      t.timestamps
    end
  end
end
