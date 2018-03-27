class CreateLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :links do |t|
      t.string :long_url, unique: true
      t.string :short_url
      t.timestamps
    end
  end
end
