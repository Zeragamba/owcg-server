class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title, :null => false
      t.text :body, :null => false, :default => ""

      t.timestamps

      t.index(:title, :unique => true)
    end
  end
end
