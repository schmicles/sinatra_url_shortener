class AddCountToShortUrls < ActiveRecord::Migration
  def change
    add_column :short_urls, :counter, :integer, :default => 0
  end
end
