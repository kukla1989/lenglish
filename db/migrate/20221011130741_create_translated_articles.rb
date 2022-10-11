class CreateTranslatedArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :translated_articles do |t|
      t.references :article, null: false, foreign_key: true
      t.text :translated
      t.string :language

      t.timestamps
    end
  end
end
