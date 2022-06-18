class CreateShortUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :short_urls do |t|
      t.string :target_url
      t.string :shortened_url

      t.timestamps
    end
  end
end
