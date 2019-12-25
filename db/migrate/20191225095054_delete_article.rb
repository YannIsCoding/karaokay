class DeleteArticle < ActiveRecord::Migration[6.0]
  def up
    drop_table :articles
  end
end
