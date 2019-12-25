class CreateKaraokesReal < ActiveRecord::Migration[6.0]
  def change
    create_table :karaokes do |t|
      t.string :title
      t.string :description
      t.string :location
      t.date :date
      t.timestamps null: false
    end
  end
end
