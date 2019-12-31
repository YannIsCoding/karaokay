class AddUserReferenceToKaraokes < ActiveRecord::Migration[6.0]
  def change
    add_reference :karaokes, :user, foreign_key: true
  end
end
