class AddSubjectToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :subject, :string, default: "common"
  end
end
