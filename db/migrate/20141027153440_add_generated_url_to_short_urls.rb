class AddGeneratedUrlToShortUrls < ActiveRecord::Migration
  def change
        add_column :short_urls, :generated_url, :string
  end
end
