class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, :session_token, null: false, index:true
      t.string :password_digest, null: false
      t.timestamps null: false
    end
  end
end
