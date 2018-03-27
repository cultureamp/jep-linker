class AddValueToShortUrls < ActiveRecord::Migration[5.1]
  def change
    add_column :short_urls, :value, :string
  end
end
