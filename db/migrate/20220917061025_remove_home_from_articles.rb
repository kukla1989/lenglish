class RemoveHomeFromArticles < ActiveRecord::Migration[7.0]
  def change
    remove_column :articles, :home, :string
  end
end
