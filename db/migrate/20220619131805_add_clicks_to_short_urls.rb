class AddClicksToShortUrls < ActiveRecord::Migration[7.0]
  def change
    add_column :short_urls, :clicks, :integer
  end
end
