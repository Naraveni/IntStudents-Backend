class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users,id: :uuid do |t|
      t.string :name
      t.string :username
      t.string :email
      t.string :password_digest
      t.index :email
      t.timestamps
    end
  end
end
