class CreateShortUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :short_urls do |t|
      t.integer :user_id
      t.integer :link_id

      t.timestamps
    end
  end
end
