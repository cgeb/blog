class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.integer :views_count, default: 0
      t.references :author, foreign_key: false
      t.date :publish_date
      t.boolean :is_published
      t.text :content
      t.timestamps
    end
  end
end
