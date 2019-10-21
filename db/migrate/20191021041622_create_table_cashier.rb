class CreateTableCashier < ActiveRecord::Migration[5.1]
  def change
    create_table :cashiers do |t|

      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :dni
      t.string :token_jwt
      t.integer :age
      t.date :birth_day
      t.string :password_digest
      t.string :token_jwt

      t.timestamps null: false

    end
  end
end
