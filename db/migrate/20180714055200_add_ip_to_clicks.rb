class AddIpToClicks < ActiveRecord::Migration[5.1]
  def change
    add_column :clicks ,:ip ,:string
  end
end
